# frozen_string_literal: true

module Cryptocompare
  module HttpMethods
    module Price
      RSpec.describe GenerateCustomAverage do
        subject(:generate_custom_average) { described_class.new(options) }
        let(:options) do
          {
            api_key: "123",
            pure_hash:
          }
        end
        let(:pure_hash) { false }

        describe ".perform" do
          context "when options is invalid" do
            it "fsym is not set" do
              options_without_fsym = options.merge(tsym: "USD", e: "Coinbase,Bitfinex")
              expect { generate_custom_average.perform(options_without_fsym) }.to raise_error(ArgumentError, "fsym can not be nil")
            end

            it "tsym is not set" do
              options_without_tsym = options.merge(fsym: "ETH", e: "Coinbase,Bitfinex")
              expect { generate_custom_average.perform(options_without_tsym) }.to raise_error(ArgumentError, "tsym can not be nil")
            end

            it "fsym is not a string" do
              options_fsym_is_not_string = options.merge(fsym: 10, tsym: "USD", e: "Coinbase,Bitfinex")
              expect { generate_custom_average.perform(options_fsym_is_not_string) }.to raise_error(ArgumentError, "fsym must be a string")
            end

            it "tsym is not an array" do
              options_tsym_is_not_string = options.merge(fsym: "ETH", tsym: 10, e: "Coinbase,Bitfinex")
              expect { generate_custom_average.perform(options_tsym_is_not_string) }.to raise_error(ArgumentError, "tsym must be a string")
            end

            it "e is a null" do
              options_e_is_null = options.merge(fsym: 10, tsym: "USD")
              expect { generate_custom_average.perform(options_e_is_null) }.to raise_error(ArgumentError, "e can not be nil")
            end

            it "e is not a string" do
              options_e_is_not_string = options.merge(fsym: "ETH", tsym: "USD", e: 1)
              expect { generate_custom_average.perform(options_e_is_not_string) }.to raise_error(ArgumentError, "e must be a string")
            end
          end

          context "when success response" do
            let(:body) { JSON.dump("ETH" => 15.23, "USD" => 29_843.3) }
            let(:response) { generate_custom_average.perform(fsym: "BTC", tsym: "USD", e: "Coinbase,Bitfinex") }

            before do
              stub_request(:get, "https://min-api.cryptocompare.com/data/generateAvg?apiKey=123&fsym=BTC&tsym=USD&e=Coinbase,Bitfinex")
                .with(headers: { "Accept" => "*/*", "Content-Type" => "application/json" })
                .to_return(status: 200, body:, headers: {})
            end

            it { expect(response).to be_a Cryptocompare::Success }
            it { expect(response.status).to be true }
            it { expect(response.error).to be_nil }
            it { expect(response.value.env.response_body).to eq(body) }
          end
        end

        describe ".perform!" do
          context "when options is invalid" do
            it "fsym is not set" do
              options_without_fsym = options.merge(tsym: "USD", e: "Coinbase,Bitfinex")
              expect { generate_custom_average.perform(options_without_fsym) }.to raise_error(ArgumentError, "fsym can not be nil")
            end

            it "tsym is not set" do
              options_without_tsym = options.merge(fsym: "ETH", e: "Coinbase,Bitfinex")
              expect { generate_custom_average.perform(options_without_tsym) }.to raise_error(ArgumentError, "tsym can not be nil")
            end

            it "fsym is not a string" do
              options_fsym_is_not_string = options.merge(fsym: 10, tsym: "USD", e: "Coinbase,Bitfinex")
              expect { generate_custom_average.perform(options_fsym_is_not_string) }.to raise_error(ArgumentError, "fsym must be a string")
            end

            it "tsym is not an array" do
              options_tsym_is_not_string = options.merge(fsym: "ETH", tsym: 10, e: "Coinbase,Bitfinex")
              expect { generate_custom_average.perform(options_tsym_is_not_string) }.to raise_error(ArgumentError, "tsym must be a string")
            end

            it "e is a null" do
              options_e_is_null = options.merge(fsym: 10, tsym: "USD")
              expect { generate_custom_average.perform(options_e_is_null) }.to raise_error(ArgumentError, "e can not be nil")
            end

            it "e is not a string" do
              options_e_is_not_string = options.merge(fsym: "ETH", tsym: "USD", e: 1)
              expect { generate_custom_average.perform(options_e_is_not_string) }.to raise_error(ArgumentError, "e must be a string")
            end
          end
        end
      end
    end
  end
end
