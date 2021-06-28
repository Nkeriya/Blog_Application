class Comment < ApplicationRecord
  belongs_to :article

  validates :commenter, presence: true, length: {minimum: 5}
  validates :body, presence: true
end
