class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :token
      t.string :name
      t.integer :chats_count, default: 0
      t.timestamp :created_at
      t.timestamp :updated_at
      primary_key :id
    end
  end
end
