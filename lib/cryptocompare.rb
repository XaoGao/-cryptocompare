# frozen_string_literal: true

require_relative "cryptocompare/version"
require_relative "cryptocompare/configuration"
require_relative "cryptocompare/errors"
require_relative "cryptocompare/client"

# Main module
module Cryptocompare
  extend Configuration
end
