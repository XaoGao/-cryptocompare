# frozen_string_literal: true

module Cryptocompare
  class Response
    attr_reader :status, :body, :error

    def initialize(status:, body:, error:)
      raise ArgumentError "status can not be nil" if status.nil?
      raise ArgumentError "status must be boolean" unless [true, false].include?(status)

      @status = status
      @body = body
      @error = error
    end

    def success?
      status
    end

    def failure?
      !status
    end
  end
end
