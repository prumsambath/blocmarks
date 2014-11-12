class EmailProcessor
  SIMPLE_URL_PATTERN = /https?:\/\/[\S]+/
  HASHTAG_PATTERN = /(?:\s|^)(?:#(?!(?:\d+|\w+?_|_\w+?)(?:\s|$)))(\w+)(?=\s|$)/i

  def initialize(email)
    @email = email
  end

  def process
    user = User.find_by(email: @email.from[:email])
    if user
      links = scan_url(@email.body)
      links.each do |link|
        user_bookmark = user.bookmarks.create(url: link)

        hashtags = scan_hashtag(@email.subject)
        hashtags.each do |text|
          user_bookmark.hashtags.create(text: text)
        end
      end
    else
      respond_email_once_to_unregistered_user
    end
  end

  def respond_email_once_to_unregistered_user
    unsigned_up_user = UnsignedUpUser.find_by(email: @email.from[:email])
    unless unsigned_up_user
      UnsignedUpUser.create(name: @email.from[:email], email: @email.from[:email])
      UnsignedUpUserMailer.response(@email).deliver
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
