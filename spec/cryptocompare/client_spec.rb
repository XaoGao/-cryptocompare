# frozen_string_literal: true

module Cryptocompare
  RSpec.describe Client do
    let(:options) { { api_key: "123" } }
    let(:client) { described_class.new(options) }

    describe ".convert" do
      it do
        stub_request(:get, "https://min-api.cryptocompare.com/data/price?apiKey=123&fsym=BTC&tsyms=ETH,UDS")
          .with(headers: { "Accept" => "*/*", "Content-Type" => "application/json" })
          .to_return(status: 200, body: "", headers: {})
        response = client.convert(fsym: "BTC", tsyms: %w[ETH UDS])
        expect(response).to be nil
      end
    end
  end
end
