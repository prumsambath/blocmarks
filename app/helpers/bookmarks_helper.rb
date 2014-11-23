module BookmarksHelper
  def hashtag_links(hashtags)
    hashtags.split(' ').map { |tag| link_to(tag.strip, hashtag_path(tag.strip),
                              class: 'btn btn-info btn-xs') }.join(' ')
  end
end
