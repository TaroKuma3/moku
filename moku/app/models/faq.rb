class Faq < ApplicationRecord
  belongs_to :user

  validates :questions, presence: true, uniqueness: true
  validates :answer, presence: true
  validates :user_id, presence: true

  acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :categories
end
