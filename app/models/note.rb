class Note < ApplicationRecord
  has_rich_text :body
  validates :title, :body, presence: true
  belongs_to :user
end
