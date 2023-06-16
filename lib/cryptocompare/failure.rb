# frozen_string_literal: true

module Cryptocompare
  class Failure < Response
    def initialize(body:, error:)
      super(status: false, body:, error:)
    end
  end
end
