# frozen_string_literal: true

module Cryptocompare
  module HttpMethods
    module Price
      class GenerateCustomAverage < AbstractRequest
        # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
        def perform(args, &block)
          check_params(fsym: args[:fsym], tsyms: args[:tsyms], e: args[:e])
          hash_query_params = create_query_params(options) do |dup|
            dup[:fsym] = args[:fsym]
            dup[:tsyms] = args[:tsyms].join(",")
            dup[:e] = args[:e]
          end

          conn = http_client_factory.create do |f|
            yield(f) if block
          end

          response = conn.get do |req|
            req.url "/data/generateAvg"
            req.params = hash_query_params
          end

          return_response(response)
        end
        # rubocop:enable Metrics/MethodLength, Metrics/AbcSize

        def query_params
          %i[api_key extra_params sign].freeze
        end

        private

        def check_params(fsym:, tsyms:, e:)
          raise ArgumentError, "fsym can not be nil" if fsym.nil?
          raise ArgumentError, "tsyms can not be nil" if tsyms.nil?
          raise ArgumentError, "e can not be nil" if e.nil?
          raise ArgumentError, "fsym must be a string" unless fsym.is_a?(String)
          raise ArgumentError, "tsyms must be an array" unless tsyms.is_a?(Array)
          raise ArgumentError, "e must be a string" unless e.is_a?(String)
        end
      end
    end
  end
end
