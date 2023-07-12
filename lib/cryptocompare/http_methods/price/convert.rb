# frozen_string_literal: true

module Cryptocompare
  module HttpMethods
    module Price
      class Convert < AbstractRequest
        # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
        def perform(args, &block)
          check_params(fsym: args[:fsym], tsyms: args[:tsyms])
          query_params = create_query_params(options) do |dup|
            dup[:fsym] = args[:fsym]
            dup[:tsyms] = args[:tsyms].join(",")
          end

          conn = http_client_factory.create do |f|
            yield(f) if block
          end

          response = conn.get do |req|
            req.url "/data/price"
            req.params = query_params
          end

          return_response(response)
        end
        # rubocop:enable Metrics/MethodLength, Metrics/AbcSize

        def query_params
          %i[api_key try_conversion relaxed_validation e extra_params sign].freeze
        end

        private

        def check_params(fsym:, tsyms:)
          raise ArgumentError, "fsym can not be nil" if fsym.nil?
          raise ArgumentError, "tsyms can not be nil" if tsyms.nil?
          raise ArgumentError, "fsym must be a string" unless fsym.is_a?(String)
          raise ArgumentError, "tsyms must be an array" unless tsyms.is_a?(Array)
        end
      end
    end
  end
end
