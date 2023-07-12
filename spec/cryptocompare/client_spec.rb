# frozen_string_literal: true

module Cryptocompare
  RSpec.describe Client do
    let(:options) { { api_key: "123" } }
    let(:client) { described_class.new(options) }

    describe "#get" do
      before do
        described_class.configuration do |config|
          config.api_key = "api_key"
          config.try_conversion = "try_conversion"
          config.relaxed_validation = "relaxed_validation"
          config.e = "e"
          config.extra_params = "extra_params"
        end
      end

      it "create instance" do
        cleint = described_class.get(api_key: "123")

        expect(cleint.send(:options)[:api_key]).to eq("123")
      end

      it "same object" do
        cleint1 = described_class.get(api_key: "123")
        client2 = described_class.get(api_key: "456")

        expect(cleint1.object_id).to eq(client2.object_id)
      end
    end

    describe ".convert" do
      context "when success response" do
        let(:body) { JSON.dump("ETH" => 15.23, "USD" => 29_843.3) }
        let(:response) { client.convert(fsym: "BTC", tsyms: %w[ETH USD]) }

        before do
          stub_request(:get, "https://min-api.cryptocompare.com/data/price?apiKey=123&fsym=BTC&tsyms=ETH,USD")
            .with(headers: { "Accept" => "*/*", "Content-Type" => "application/json" })
            .to_return(status: 200, body:, headers: {})
        end

        it { expect(response).to be_a Cryptocompare::Success }
        it { expect(response.status).to be true }
        it { expect(response.error).to be_nil }
        it { expect(response.value.env.response_body).to eq(body) }
      end
    end

    describe ".full_data" do
      context "when success response" do
        let(:body) { JSON.dump("ETH" => 15.23, "USD" => 29_843.3) }
        let(:response) { client.full_data(fsym: "BTC", tsyms: %w[ETH USD]) }

        before do
          stub_request(:get, "https://min-api.cryptocompare.com/data/pricemultifull?apiKey=123&fsym=BTC&tsyms=ETH,USD")
            .with(headers: { "Accept" => "*/*", "Content-Type" => "application/json" })
            .to_return(status: 200, body:, headers: {})
        end

        it { expect(response).to be_a Cryptocompare::Success }
        it { expect(response.status).to be true }
        it { expect(response.error).to be_nil }
        it { expect(response.value.env.response_body).to eq(body) }
      end
    end
  end
end
