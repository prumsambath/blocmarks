class EmailProcessor
  SIMPLE_URL_PATTERN = /https?:\/\/[\S]+/
  HASHTAG_PATTERN = /(?:\s|^)(?:#(?!(?:\d+|\w+?_|_\w+?)(?:\s|$)))(\w+)(?=\s|$)/i

  def initialize(email)
    @email = email
  end

  def process
    puts "Class: #{@email.class}"
    puts "inspect: @email.inspect"
    puts "sender: @email.from[:email]"
    puts "subject: @email.subject"
    puts "body: @email.body"

    user = User.find_by(email: @email[:from])
    if user
      links = scan_url(@email[:body])
      links.each do |link|
        bookmark = Bookmark.create(url: link)
        user.favorites.build(bookmark: bookmark)

        hashtags = scan_hashtag(@email[:subject])
        hashtags.each do |text|
          bookmark.hashtags.create(text: text)
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