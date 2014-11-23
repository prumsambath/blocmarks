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
        bookmark = Bookmark.new(url: link)
        bookmark.all_hashtags = scan_hashtag(@email.subject).join(' ')
        user.bookmarks << bookmark
      end
      user.save
    else
      respond_email_once_to_unregistered_user
    end
  end

  def respond_email_once_to_unregistered_user
    unsigned_up_user = UnsignedUpUser.find_by(email: @email.from[:email])
    unless unsigned_up_user
      user = UnsignedUpUser.create(name: @email.from[:name], email: @email.from[:email])
      user.send_email
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
