# frozen_string_literal: true

module Cryptocompare
  using Utils

  class Client
    extend Configuration

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

    def full_data(fsym:, tsyms:, &block)
      HttpMethods::Price::FullData.new(options).perform(fsym:, tsyms:, &block)
    end

    private

    attr_reader :options
  end
end
