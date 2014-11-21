class Bookmark < ActiveRecord::Base
  has_many :categorizations
  has_many :hashtags, through: :categorizations, dependent: :destroy
  belongs_to :user

  validates :url, presence: true, uniqueness: { scope: :user_id }

  scope :not_own_by, -> (user) { user ? where("user_id != ?", user.id) : all }
end
