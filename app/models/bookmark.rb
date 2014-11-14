class Bookmark < ActiveRecord::Base
  has_many :categorizations
  has_many :hashtags, through: :categorizations
  belongs_to :user

  validates :url, presence: true, uniqueness: { scope: :user_id }
end
