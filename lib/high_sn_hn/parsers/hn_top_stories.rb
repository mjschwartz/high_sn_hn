module HighSnHn

  class HnTopStories
    include HTTParty
    base_uri 'https://hacker-news.firebaseio.com'
    format :json

    attr_reader :stories

    def initialize
      @stories = get()
    end

    def get
      response  = self.class.get("/v0/topstories.json",
        options: {headers: {'Content-Type' => 'application/json'} })
      response.parsed_response
    end

  end
end