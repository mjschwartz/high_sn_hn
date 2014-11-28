module HighSnHn

  # error for when the API return a null body
  class NullItemResult < RuntimeError; end

  class HnItem
    include HTTParty
    base_uri 'https://hacker-news.firebaseio.com'
    format :json

    attr_reader :data, :model

    def initialize(id)
      @id = id
      @model = false
    end

    def complete?
      # we haven't fetched so we don't know which type of item this is
      # will look and see if we have a comment or story matching
      item = HighSnHn::Story.where(hn_id: @id).first
      item = HighSnHn::Comment.where(hn_id: @id).first if item.nil?
      @data = item.data_attributes if item
      item && item.complete?
    end

    def fetch
      @data = HighSnHn::HnResponse.new(get(@id))
      if klass = @data.klass
        @model = klass.where(hn_id: @id).first_or_initialize
        @model.update(@data)
      end
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