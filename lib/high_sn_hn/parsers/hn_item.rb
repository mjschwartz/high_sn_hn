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
      item = HighSnHn::Story.where(hn_id: @id).first
      item = HighSnHn::Comment.where(hn_id: @id).first if item.nil?
      @data = item.attributes if item
      item && item.complete?
    end

    def fetch
      LOGGER.info("Fetching HnItem ##{@id}")
      @data = get(@id)
      setup_model()
    end

    def setup_model
      if @data['type'] == 'story'
        klass = HighSnHn::Story
      elsif @data['type'] == 'comment'
        klass = HighSnHn::Comment
      end

      if klass
        @model = klass.where(hn_id: @id).first_or_create
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