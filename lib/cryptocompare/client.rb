# frozen_string_literal: true

require "json"

module Cryptocompare
  using Utils

  class Client
    extend Configuration

    AVAILABLE_KEYS = %i[api_key try_conversion relaxed_validation e extra_params sign pure_hash].freeze
    QUERY_PARAMS = %i[api_key try_conversion relaxed_validation e extra_params sign].freeze

    def self.get(options = {})
      @instance = new(options) if @instance.nil?

      @instance
    end

    def initialize(options)
      @options = options
    end

    def convert(fsym:, tsyms:, &block)
      HttpMethods::Price::Convert.new(options).perform(fsym:, tsyms:, &block)
    end

    private

    attr_reader :options
  end
end
