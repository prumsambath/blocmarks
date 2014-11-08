class Bookmark < ActiveRecord::Base
  has_many :categorizations
  has_many :hashtags, through: :categorizations
  belongs_to :user

  scope :visible_to, -> (user) { user ? where("user_id = ?", user.id) : all }
end
