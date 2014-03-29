class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|  
      t.string :header, null: false
      t.text :content
      t.integer :user_id

      t.timestamps
    end
  end
end
