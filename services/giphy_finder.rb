module Services
  class GiphyFinder
    class << self
      def call(api_key, tag = nil)
        new(api_key, tag).call
      end
    end

    def initialize(api_key, tag)
      @api_key = api_key
      @tag = tag
    end

    def call
      url = 'api.giphy.com/v1/gifs/random'
      options = {
        params: {
          api_key: @api_key,
          tag: @tag
        }
      }
      response = RestClient.get(url, options)
      JSON.parse(response).dig('data', 'images', 'downsized', 'url')
    end
  end
end
