# frozen_string_literal: true

require "debug"
require_relative "cryptocompare/utils/string"
require_relative "cryptocompare/utils/hash"
require_relative "cryptocompare/http_client_factory"
require_relative "cryptocompare/version"
require_relative "cryptocompare/configuration"
require_relative "cryptocompare/errors"
require_relative "cryptocompare/response"
require_relative "cryptocompare/failure"
require_relative "cryptocompare/success"
require_relative "cryptocompare/http_methods/concerns/paramable"
require_relative "cryptocompare/http_methods/concerns/responsable"
require_relative "cryptocompare/http_methods/abstract_request"
require_relative "cryptocompare/http_methods/price"
require_relative "cryptocompare/client"

# Main module
module Cryptocompare
  extend Configuration
end
