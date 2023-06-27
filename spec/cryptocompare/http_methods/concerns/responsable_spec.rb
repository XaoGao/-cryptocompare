# frozen_string_literal: true

module Cryptocompare
  module HttpMethods
    module Concerns
      RSpec.describe Responsable do
        let(:dummy_class) { Class.new { include Responsable } }
        let(:dummy_instance) { dummy_class.new }

        describe ".check_condition_pure_hash" do
          context "when pure hash is true" do
            let(:faraday_response) { instance_double(Faraday::Response, body: JSON.generate({ "x" => 1, "y" => 2 })) }
            let(:options) { { pure_hash: true } }
            let(:result) { dummy_instance.check_condition_pure_hash(faraday_response) }

            before do
              allow(dummy_instance).to receive(:options).and_return({ pure_hash: true })
            end

            it "parse json to hash" do
              expect(result).to be_a(Hash)
            end

            it "value is hash" do
              expect(result).to eq({ "x" => 1, "y" => 2 })
            end
          end

          context "when pure hash is false" do
            let(:faraday_response) { instance_double(Faraday::Response, body: JSON.generate({ "x" => 1, "y" => 2 })) }
            let(:result) { dummy_instance.check_condition_pure_hash(faraday_response) }

            before do
              allow(dummy_instance).to receive(:options).and_return({ pure_hash: false })
            end

            it "parse json to Cryptocompare::Success" do
              expect(result).to be_a(Cryptocompare::Success)
            end

            it "value is all object" do
              expect(result.body).to eq(faraday_response)
            end
          end
        end

        describe ".return_response" do
          let(:faraday_response) { instance_double(Faraday::Response, body: JSON.generate({ "x" => 1, "y" => 2 })) }

          context "when response is success" do
            before do
              allow(faraday_response).to receive(:success?).and_return(true)
              allow(dummy_instance).to receive(:options).and_return({ pure_hash: false })
            end

            it { expect(dummy_instance.return_response(faraday_response)).to be_a(Cryptocompare::Success) }
          end

          context "when response is failure" do
            before do
              allow(faraday_response).to receive(:success?).and_return(false)
            end

            it { expect(dummy_instance.return_response(faraday_response)).to be_a(Cryptocompare::Failure) }
          end
        end
      end
    end
  end
end
