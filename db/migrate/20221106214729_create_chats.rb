class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.belongs_to :application
      t.string :name
      t.integer :chat_number 
      t.integer :messages_count, default: 0
      t.timestamp :created_at
      t.timestamp :updated_at
      primary_key :id
    end
    add_foreign_key(:chats, :applications)
  end
end
