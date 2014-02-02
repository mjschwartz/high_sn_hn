module HighSnHn

  class GenerateShortlink

    def initialize(link)
      @link = link
      @apikey = HighSnHn::Keys.google["key"]
    end

    def shorten
      response = JSON.parse(request)
      response["id"]
    end

    def request
      require 'net/http'
      require 'net/https'
      http = Net::HTTP.new('www.googleapis.com', 443)
      http.use_ssl = true
      url = '{"longUrl": "' + @link + '"}'
      path = '/urlshortener/v1/url?key=' + @apikey
      headers = {'Content-Type'=> 'application/json'}

      resp = http.post(path, url, headers)

      if resp.code == "200"
        return resp.body
      else
        return '{}'
      end
    end

  end

end