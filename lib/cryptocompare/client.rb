# frozen_string_literal: true

require "faraday"

module Cryptocompare
  class Client
    API_URL = "https://min-api.cryptocompare.com"
    AVAILABLE_KEYS = %i[api_key try_conversion relaxed_validation e extra_params sign pure_hash].freeze

    def initialize(api_key:, options: {})
      @options = check_options(options).merge(api_key:)
    end

    def convert(fsym:, tsyms:, &block)
      check_params(fsym:, tsyms:)

      http = Faraday.new(
        url: API_URL,
        headers: { "Content-Type" => "application/json" }
      )

      options.merge(fsym:, tsyms: tsyms.join(","))

      http.get("/data/price", params: options)
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
      options.select { |key, _| AVAILABLE_KEYS.include? key }
    end
  end
end
