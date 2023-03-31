# frozen_string_literal: true

module Cryptocompare
  # nodoc:
  module Configuration
    attr_accessor :logger, :api_key, :try_conversion, :relaxed_validation, :e, :extra_params, :sign, :pure_hash

    def configuration
      yield self
    end
  end
end
