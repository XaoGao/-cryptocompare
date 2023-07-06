# frozen_string_literal: true

module Cryptocompare
  class NotSuccessful < StandardError
    attr_reader :result

    def initialize(result)
      super()
      @result = result
    end
  end

  class InternalError < StandardError
  end
end
