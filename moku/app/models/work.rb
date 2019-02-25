class Work < ApplicationRecord
  belongs_to :moku
  belongs_to :user
  has_many :book_marks

  has_many_attached :images

  validates :moku_id, presence: true
  validates :user_id, presence: true
  validates :title, presence: true
  validates :comment_public, inclusion: { in: [true, false] }
  validates :pickup_public, inclusion: { in: [true, false] }

end
