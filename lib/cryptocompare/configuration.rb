# frozen_string_literal: true

module Cryptocompare
  module Configuration
    attr_accessor :api_key, :try_conversion, :relaxed_validation, :e, :extra_params, :sign, :pure_hash

    def configuration
      yield self
    end
  end
end
