class MokuType < ApplicationRecord
  belongs_to :user
  has_many :mokus

  validates :name, presence: true
  validates :user_id, presence: true
end
