class MokuType < ApplicationRecord
  belongs_to :user
  has_many :do_mokus

  validates :name, presence: true
  validates :user_id, presence: true
end
