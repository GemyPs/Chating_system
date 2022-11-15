class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.belongs_to :chat
      t.string :message
      t.integer :message_number
      t.timestamp :created_at
      t.timestamp :updated_at
      primary_key :id
    end
    add_foreign_key(:messages, :chats)
  end
end
