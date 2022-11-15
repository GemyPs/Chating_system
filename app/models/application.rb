class Application < ApplicationRecord
    validates :name, presence: true
    has_many :chat, dependent: :destroy
end
