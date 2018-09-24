require_relative '../services/giphy_finder'

module Lita
  module Handlers
    class Giphy < Handler
      config :api_key, required: true

      route(/^giphy$/i,
            :random,
            help: { 'giphy' => 'Returns a random Giphy image.' })
      route(/^gif$/i,
            :random,
            help: { 'gif' => 'Returns a random Giphy image.' })
      route(/^giphy\s+(.+)$/i,
            :search,
            help: { 'giphy [keyword]' => 'Returns a random Giphy image with the specified keyword applied.' })
      route(/^gif\s+(.+)$/i,
            :search,
            help: { 'gif [keyword]' => 'Returns a random Giphy image with the specified keyword applied.' })

      def random(response)
        return unless validate(response)
        response.reply(Services::GiphyFinder.call(config.api_key))
      end

      def search(response)
        return unless validate(response)
        response.reply(Services::GiphyFinder.call(config.api_key, response.match_data[1]))
      end

      Lita.register_handler(self)

      private

      def validate(response)
        if config.api_key.nil?
          response.reply 'Missing Giphy API key'
          return false
        end
        true
      end
    end
  end
end
