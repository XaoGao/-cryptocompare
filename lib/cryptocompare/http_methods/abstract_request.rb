# frozen_string_literal: true

# nodoc:
module Cryptocompare
  module HttpMethods
    using Utils

    class AbstractRequest
      include Concerns::Paramable
      include Concerns::Responsable

      attr_reader :http_client_factory, :options

      def initialize(options = {})
        @options = filter_options(options)
        @http_client_factory = HttpClientFactory.new
      end

      def perform(_args, &)
        raise NotImplementedError, "'perform' must be implemented in #{self.class}"
      end

      def perform!(args, &)
        result = perform(args, &)

        return result if result.is_a?(Hash) || result.success?

        raise NotSuccessful, result
      end
    end
  end
end
