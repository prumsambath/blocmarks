class BookmarkMailer < ActionMailer::Base
  default from: "from@example.com"

  SIMPLE_URL_PATTERN = /https?:\/\/[\S]+/
  HASHTAG_PATTERN = /(?:\s|^)(?:#(?!(?:\d+|\w+?_|_\w+?)(?:\s|$)))(\w+)(?=\s|$)/i

  def self.receive(email)
    return if email[:body].blank? || (email[:body].scan(SIMPLE_URL_PATTERN).count == 0)
    Bookmark.create(url: email[:body])
  end
end
