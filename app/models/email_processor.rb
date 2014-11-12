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
      unsignedu_up_user = UnsignedUpUser.find(email: @email.from[:email])
      if unsignedu_up_user
        if unsignedu_up_user.email_received_count < 3
          UnsignedupUserMailer.respond(@email).deliver
          unsignedu_up_user.update_attribute(:email_received_count, unsigned_up_user.email_received_count + 1)
        end
      else
        UnsignedUpUser.create(name: @email.from, email: @email.from[:email])
      end

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
