class DoMoku < ApplicationRecord
  belongs_to :user
  belongs_to :moku_type
  has_many :works

  validates :user_id, presence: true
  validates :moku_type_id, presence: true
  validates :started_at, presence: true

  #update == moku終了時以降
  # validates :finished_at, presence: true, on: :update(このせいで削除する時にもバリデーションエラーが出る)
  validates :moku_time, presence: true, on: :update

  def format_created_at
    self.created_at.strftime('%y/%m/%d  %H:%M')
  end
end
