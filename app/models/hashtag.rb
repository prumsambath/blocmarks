class Hashtag < ActiveRecord::Base
  has_many :categorizations
  has_many :bookmarks, through: :categorizations

  default_scope { order(:text) }
end
