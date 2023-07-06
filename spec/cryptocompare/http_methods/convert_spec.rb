# frozen_string_literal: true

module Cryptocompare
  module HttpMethods
    RSpec.describe Convert do
      subject(:convert) { described_class.new(options) }
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
            options_without_fsym = options.merge(tsyms: %w[ETH USD])
            expect { convert.perform(options_without_fsym) }.to raise_error(ArgumentError, "fsym can not be nil")
          end

          it "tsyms is not set" do
            options_without_tsyms = options.merge(fsym: "ETH")
            expect { convert.perform(options_without_tsyms) }.to raise_error(ArgumentError, "tsyms can not be nil")
          end

          it "fsym is not a string" do
            options_fsym_is_not_string = options.merge(fsym: 10, tsyms: %w[ETH USD])
            expect { convert.perform(options_fsym_is_not_string) }.to raise_error(ArgumentError, "fsym must be a string")
          end

          it "tsyms is not an array" do
            options_fsym_is_not_array = options.merge(fsym: "ETH", tsyms: "USD")
            expect { convert.perform(options_fsym_is_not_array) }.to raise_error(ArgumentError, "tsyms must be an array")
          end
        end

        context "when success response" do
          let(:body) { JSON.dump("ETH" => 15.23, "USD" => 29_843.3) }
          let(:response) { convert.perform(fsym: "BTC", tsyms: %w[ETH USD]) }

          before do
            stub_request(:get, "https://min-api.cryptocompare.com/data/price?apiKey=123&fsym=BTC&tsyms=ETH,USD")
              .with(headers: { "Accept" => "*/*", "Content-Type" => "application/json" })
              .to_return(status: 200, body:, headers: {})
          end

          it { expect(response).to be_a Cryptocompare::Success }
          it { expect(response.status).to be true }
          it { expect(response.error).to be_nil }
          it { expect(response.body.env.response_body).to eq(body) }
        end
      end

      describe ".perform!" do
        context "when options is invalid" do
          it "fsym is not set" do
            options_without_fsym = options.merge(tsyms: %w[ETH USD])
            expect { convert.perform!(options_without_fsym) }.to raise_error(ArgumentError, "fsym can not be nil")
          end

          it "tsyms is not set" do
            options_without_tsyms = options.merge(fsym: "ETH")
            expect { convert.perform!(options_without_tsyms) }.to raise_error(ArgumentError, "tsyms can not be nil")
          end

          it "fsym is not a string" do
            options_fsym_is_not_string = options.merge(fsym: 10, tsyms: %w[ETH USD])
            expect { convert.perform!(options_fsym_is_not_string) }.to raise_error(ArgumentError, "fsym must be a string")
          end

          it "tsyms is not an array" do
            options_fsym_is_not_array = options.merge(fsym: "ETH", tsyms: "USD")
            expect { convert.perform!(options_fsym_is_not_array) }.to raise_error(ArgumentError, "tsyms must be an array")
          end

          context "when failure response" do
            let(:body) { JSON.dump("ETH" => 15.23, "USD" => 29_843.3) }

            before do
              stub_request(:get, "https://min-api.cryptocompare.com/data/price?apiKey=123&fsym=BTC&tsyms=ETH,USD")
                .with(headers: { "Accept" => "*/*", "Content-Type" => "application/json" })
                .to_return(status: 400, body: "some error", headers: {})
            end

            it "raise error" do
              expect { convert.perform!(fsym: "BTC", tsyms: %w[ETH USD]) }.to raise_error(NotSuccessful)
            end
          end
        end
      end
    end
  end
end
