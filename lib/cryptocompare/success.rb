# frozen_string_literal: true

module Cryptocompare
  class Success < Response
    def initialize(body:)
      super(status: true, body:, error: nil)
    end
  end
end
