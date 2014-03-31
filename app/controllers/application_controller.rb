class ApplicationController < ActionController::Base
  require 'redcarpet'
  helper_method :markdown

  def markdown(text)
    extensions = {
      fenced_code_blocks: true,
      autolink: true,
      filter_html: true,
      safe_links_only: true,
      hard_wrap: true,
      prettify: true,
      list: true
    }
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(extensions))
    markdown.render(text).html_safe
  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
