class MokuType < ApplicationRecord
  belongs_to :user
  has_many :do_mokus

  validates :name, presence: true
  validates :user_id, presence: true

  #will_paginateの１ページあたりの表示件数指定
  self.per_page = 5

end
