# frozen_string_literal: true

module Cryptocompare
  class Success < Response
    def initialize(value:)
      super(status: true, value:, error: nil)
    end
  end
end
