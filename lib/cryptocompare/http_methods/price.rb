# frozen_string_literal: true

module Cryptocompare
  module HttpMethods
    class Price < AbstractRequest
      def initialize(options)
        @options = options
        super
      end

      # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
      def perform(options)
        check_params(fsym: options[:fsym], tsyms: options[:tsyms])
        query_params = create_query_params(options) do |dup|
          dup.merge(fsym:, tsyms: tsyms.join(","))
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

      private

      def check_params(fsym:, tsyms:)
        raise ArgumentError "fsym can not be nil" if fsym.nil?
        raise ArgumentError "tsyms can not be nil" if tsyms.nil?
        raise ArgumentError "fsym must be a string" unless fsym.is_a?(String)
        raise ArgumentError "tsyms must be a array" unless tsyms.is_a?(Array)
      end
    end
  end
end
