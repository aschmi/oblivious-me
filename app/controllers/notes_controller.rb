class NotesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  # GET /notes
  # GET /notes.json
  def index
    #@notes = current_user.notes
    # @note = Note.new

    # @tags = current_user.owned_tags

    if params[:id]
      (session[:selected_tags] ||= []) << params[:id]
    elsif params[:remove_id] && session[:selected_tags] && !session[:selected_tags].empty?
      session[:selected_tags].delete(params[:remove_id])
    end

    if !session[:selected_tags].nil?
      @selected_tags = ActsAsTaggableOn::Tag.find(session[:selected_tags])
    else
      @selected_tags = []
    end

    # @notes = Note.tagged_with(@selected_tags)

    @note = Note.new

    #@tags = current_user.notes.tags


    #@notes = current_user.notes
    if @selected_tags.empty?
      @tags = current_user.owned_tags
      @notes = current_user.notes
    else
      @notes = Note.tagged_with(@selected_tags, owned_by: current_user)
      @tags = Set.new
      @notes.map do |n|
        n.taggings.map do |tagging|
          @tags << ActsAsTaggableOn::Tag.find(tagging.tag_id)
        end
      end
    end

    # @notes.map do |n|
    #   @tags << n.tags
    # end
    
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
  end

  # GET /notes/new
  def new
    @note = Note.new
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = Note.new(note_params)
    #@note.user = current_user

    respond_to do |format|
      if @note.save
        current_user.tag(@note, with: note_tags(@note.header), on: :tags)
        #format.js { render partial: 'notes/note', locals: {note: @note} }
        #format.js { render json: { html: { partial: render_to_string('notes/note', layout: false, locals: {note: @note })}, content_type: 'text/json'}}
        #format.json { render json: @note }
        format.html { redirect_to notes_path, notice: 'Note was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to notes_path, notice: 'Note was successfully updated.' }
      else
        format.html { render action: 'edit' }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to notes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params.require(:note).permit(:header, :content).merge(user_id: current_user.id)
    end

    def note_tags(text)
      text.scan(/#\S+/)
    end
end
