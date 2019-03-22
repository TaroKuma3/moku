class Work < ApplicationRecord
  belongs_to :do_moku
  belongs_to :user
  has_many :book_marks

  has_many_attached :images

  validates :do_moku_id, presence: true
  validates :user_id, presence: true
  validates :title, presence: true
  validates :memo_public, inclusion: { in: [true, false] }
  validates :pickup_public, inclusion: { in: [true, false] }
end
