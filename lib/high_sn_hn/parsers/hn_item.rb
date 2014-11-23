module HighSnHn

  # error for when the API return a null body
  class NullItemResult < RuntimeError; end

  class HnItem
    include HTTParty
    base_uri 'https://hacker-news.firebaseio.com'
    format :json

    attr_reader :data

    def initialize(id)
      @id = id
    end

    def complete?
      item = HighSnHn::Story.where(hn_id: @id).first
      item = HighSnHn::Comment.where(hn_id: @id).first if item.nil?
      @data = item.attributes if item
      item && item.complete?
    end

    def fetch
      @data = get(@id)
    end

    def get(id)
      response  = self.class.get("/v0/item/#{id}.json",
        options: {headers: {'Content-Type' => 'application/json'} })

      unless response.parsed_response
        raise(NullItemResult, "The API get for item #{id} was null.")
      end

      response.parsed_response
    end

  end
end