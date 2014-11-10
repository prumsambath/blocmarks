class EmailProcessor
  SIMPLE_URL_PATTERN = /https?:\/\/[\S]+/
  HASHTAG_PATTERN = /(?:\s|^)(?:#(?!(?:\d+|\w+?_|_\w+?)(?:\s|$)))(\w+)(?=\s|$)/i

  def initialize(email)
    @email = email
  end

  def process
    user = User.find_by(email: @email[:from])
    if user
      bookmarks = scan_url(@email[:body])
      bookmarks.each do |bookmark|
        user_bookmark = user.bookmarks.build(url: bookmark)

        hashtags = scan_hashtag(@email[:subject])
        hashtags.each do |text|
          user_bookmark.hashtags.build(text: text)
        end
      end

      user.save
    end
  end

  private
    def scan_hashtag(subject)
      subject.scan(HASHTAG_PATTERN).flatten
    end

    def scan_url(body)
      body.scan(SIMPLE_URL_PATTERN).flatten
    end
end