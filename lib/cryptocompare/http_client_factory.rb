# frozen_string_literal: true

require "faraday"

module Cryptocompare
  class HttpClientFactory
    API_URL = "https://min-api.cryptocompare.com"

    def create(&block)
      Faraday.new(
        url: API_URL,
        headers: { "Content-Type" => "application/json" }
      ) do |f|
        f.request :url_encoded
        f.adapter Faraday.default_adapter
        yield(f) if block
      end
    end
  end
end
