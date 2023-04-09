# frozen_string_literal: true

require "faraday"
require "json"

module Cryptocompare
  class Client
    API_URL = "https://min-api.cryptocompare.com"
    AVAILABLE_KEYS = %i[api_key try_conversion relaxed_validation e extra_params sign pure_hash].freeze
    QUERY_PARAMS = %i[api_key try_conversion relaxed_validation e extra_params sign].freeze

    def initialize(api_key:, options: {})
      @options = check_options(options).merge(api_key:)
    end

    # TODO: Pass faraday middlware to conn
    def convert(fsym:, tsyms:, &_)
      check_params(fsym:, tsyms:)

      conn = Faraday.new(
        url: API_URL,
        headers: { "Content-Type" => "application/json" }
      )

      options.merge(fsym:, tsyms: tsyms.join(","))

      response = conn.get("/data/price", params: options)
      return_response(response)
    end

    private

    attr_reader :options

    def check_params(fsym:, tsyms:)
      raise ArgumentError "fsym can not be nil" if fsym.nil?
      raise ArgumentError "tsyms can not be nil" if tsyms.nil?

      raise ArgumentError "fsym must be a string" unless fsym.is_a?(String)
      raise ArgumentError "tsyms must be a array" unless tsyms.is_a?(Array)
    end

    def check_options(options)
      options.filter { |key, _| AVAILABLE_KEYS.include? key }
    end

    def return_response(faraday_response)
      if faraday_response.success?
        options[:pure_hash] ? JSON.parse(faraday_response.body) : Success.new(body: faraday_response)
      else
        Failure.new(body: faraday_response, error: faraday_response.body)
      end
    end

    def query_params
      options.filter { |key, _| QUERY_PARAMS.include? key }.each do |key, value|
        key = :tryConversion if key == :try_conversion
        key = :relaxedValidation if key == :relaxed_validation
      end
    end
  end
end
