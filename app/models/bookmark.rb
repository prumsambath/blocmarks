class Bookmark < ActiveRecord::Base
  has_many :categorizations
  has_many :hashtags, through: :categorizations, dependent: :destroy
  belongs_to :user

  validates :url, presence: true, uniqueness: { scope: :user_id }

  scope :not_own_by, -> (user) { user ? where("user_id != ?", user.id) : all }

  def all_hashtags=(text)
    self.hashtags = text.split.map do |text|
      Hashtag.where(text: text.strip).first_or_create!
    end
  end

  def all_hashtags
    self.hashtags.map(&:text).join(" ")
  end
end
