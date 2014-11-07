class EmailProcessor
  HASHTAG_PATTERN = /(?:\s|^)(?:#(?!(?:\d+|\w+?_|_\w+?)(?:\s|$)))(\w+)(?=\s|$)/i

  def initialize(email)
    @email = email
  end

  def process
    user = User.find_by(email: @email.from)
    if user
      bookmark = user.bookmarks.create(url: @email.body)

      hashtags = @email.subject.scan(/HASHTAG_PATTERN/).flatten
      hashtags.each do |text|
        bookmark.hashtags.create(text: text)
      end
    end
  end

  # temp attr_reader for testing
  def email
    @email
  end
end


# TODO how to handle email from users who not yet signed up
# TODO test the email object whose data populated properly