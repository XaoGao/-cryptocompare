# frozen_string_literal: true

# nodoc:
module Cryptocompare
  module HttpMethods
    using Utils

    class AbstractRequest
      include Concerns::Paramable
      include Concerns::Responsable

      attr_reader :http_client_factory

      def initialize
        @http_client_factory = HttpClientFactory.new
      end

      def perform(_options)
        raise NotImplementedError, "'perform' must be implemented in #{self.class}"
      end

      def perform!(_options)
        raise NotImplementedError, "'perform!' must be implemented in #{self.class}"
      end
    end
  end
end
