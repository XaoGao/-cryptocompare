# frozen_string_literal: true

require "json"

module Cryptocompare
  using Utils

  class Client
    AVAILABLE_KEYS = %i[api_key try_conversion relaxed_validation e extra_params sign pure_hash].freeze
    QUERY_PARAMS = %i[api_key try_conversion relaxed_validation e extra_params sign].freeze

    def self.get(options = {})
      @instance = new(options) if @instance.nil?

      @instance
    end

    def initialize(options)
      @options = filter_options(options)
      @http_client_factory = HttpClienFactory.new
    end

    def convert(fsym:, tsyms:, &block)
      check_params(fsym:, tsyms:)
      query_params = create_query_params(options, fsym, tsyms)

      conn = http_client_factory.create do |f|
        yield(f) if block
      end

      response = conn.get("/data/price", params: query_params)
      return_response(response)
    end

    private

    attr_reader :options, :http_client_factory

    def check_params(fsym:, tsyms:)
      raise ArgumentError "fsym can not be nil" if fsym.nil?
      raise ArgumentError "tsyms can not be nil" if tsyms.nil?

      raise ArgumentError "fsym must be a string" unless fsym.is_a?(String)
      raise ArgumentError "tsyms must be a array" unless tsyms.is_a?(Array)
    end

    def filter_options(options)
      options.filter { |key, _| AVAILABLE_KEYS.include? key }
    end

    def return_response(faraday_response)
      if faraday_response.success?
        check_condition_pure_hash(faraday_response)
      else
        Failure.new(body: faraday_response, error: faraday_response.body)
      end
    end

    def query_params(options, fsym, tsyms)
      options.deep_dup
             .filter { |key, _| QUERY_PARAMS.include? key }
             .merge(fsym:, tsyms: tsyms.join(","))
             .transform_keys_to_camel_case
    end

    def check_condition_pure_hash(faraday_response)
      if options[:pure_hash]
        begin
          JSON.parse(faraday_response.body)
        rescue JSON::ParserError => _e
          # TODO: need add error log, a think about throw error up or return failure?
        end
      else
        Success.new(body: faraday_response)
      end
    end
  end
end
