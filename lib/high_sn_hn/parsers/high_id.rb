module HighSnHn

  class HighId
    include HTTParty
    base_uri 'https://hacker-news.firebaseio.com'
    format :json

    attr_reader :id

    def initialize
      @id = get()
    end

    def get
      response  = self.class.get("/v0/maxitem.json",
        options: {headers: {'Content-Type' => 'application/json'} })
      response.parsed_response
    end

  end
end