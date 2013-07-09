require 'open-uri'
class Stream

  attr_accessor :body

  POSTS_URL = "https://alpha-api.app.net/stream/0/posts/stream/global"

  def initialize
    response = open(URI.parse(POSTS_URL))
    case response.status[0].to_i
    when 200
      @body = NestedStruct.new(ActiveSupport::JSON.decode(response))
    when 404
      { error: "Can't get data form url #{POSTS_URL}" }
    else
      []
    end
  end
end
