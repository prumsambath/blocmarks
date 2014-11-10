module ApplicationHelper
  def embedly_api
    Embedly::API.new key: ENV['embedly_api_key'], :user_agent => 'Mozilla/5.0 (compatible)', width: '200px', height: '150px'
  end
end
