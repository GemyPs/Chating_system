class Message < ApplicationRecord
    validates :message, presence: true
    belongs_to :chat
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    mapping do
        indexes :message, type: 'text'
        indexes :message_number, type: 'integer'
        indexes :chat_number, type: 'integer'
    end
    def as_indexed_json(options = {})
        self.as_json(
          options.merge(
            only: [
              :message,
              :message_number,
              :chat_number
            ],
            include: { chat: { only: [:chat_number, :name] } }
          )
        )
    end

end
