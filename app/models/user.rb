class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :moku_types
  has_many :moku_types
  has_many :works
  has_many :book_marks
  has_many :faqs

  after_create :insert_default_moku_type

  validates :admin, inclusion: { in: [true, false] }
  validates :name, presence: true
  validates :public, inclusion: { in: [true, false] }
  validates :introduce, length: {maximum: 140}

  validates :accepted, presence: {message: 'を入力してください'} #利用規約同意のバリデ

  def active_for_authentication?
    if self.deleted
      false
    else
      super
    end
  end

  def inactive_message
    if self.deleted
      :moku_deleted #config/locales/devise.ja.ymlの自作メッセージ参照指示
    else
      super
    end
  end

  def active_moku_types
    moku_types = MokuType.where(deleted: false).where(user_id: self.id)
  end

  private
  def insert_default_moku_type
    moku_type = MokuType.new(
      user_id: self.id,
      name: "とりあえずmokuる",
    )
    moku_type.save!
  end

end
