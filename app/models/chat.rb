class Chat < ApplicationRecord
    validates :name, presence: true
    has_many :message, dependent: :destroy
end
