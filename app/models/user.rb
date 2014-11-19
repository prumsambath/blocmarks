class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :bookmarks, dependent: :destroy
  has_many :favorites, dependent: :destroy
  mount_uploader :avatar, AvatarUploader

  validates :name, presence: true

  def liked(bookmark)
    favorites.where(bookmark_id: bookmark.id).first
  end
end
