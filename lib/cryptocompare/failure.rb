# frozen_string_literal: true

module Cryptocompare
  class Failure < Response
    def initialize(value:, error:)
      super(status: false, value:, error:)
    end
  end
end
