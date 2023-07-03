# frozen_string_literal: true

module Cryptocompare
  RSpec.describe Client do
    let(:options) { { api_key: "123" } }
    let(:client) { described_class.new(options) }

    # describe ".convert" do
    #   context "when success response" do
    #     let(:body) { JSON.dump("ETH" => 15.23, "USD" => 29_843.3) }
    #     let(:response) { client.convert(fsym: "BTC", tsyms: %w[ETH USD]) }

    #     before do
    #       stub_request(:get, "https://min-api.cryptocompare.com/data/price?apiKey=123&fsym=BTC&tsyms=ETH,USD")
    #         .with(headers: { "Accept" => "*/*", "Content-Type" => "application/json" })
    #         .to_return(status: 200, body:, headers: {})
    #     end

    #     it { expect(response).to be_a Cryptocompare::Success }
    #     it { expect(response.status).to be true }
    #     it { expect(response.error).to be_nil }
    #     it { expect(response.body.env.response_body).to eq(body) }
    #   end
    # end
  end
end
