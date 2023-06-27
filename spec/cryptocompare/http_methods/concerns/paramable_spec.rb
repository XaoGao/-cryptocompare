# frozen_string_literal: true

module Cryptocompare
  module HttpMethods
    module Concerns
      RSpec.describe Paramable do
        let(:dummy_class) { Class.new { include Paramable } }
        let(:dummy_instance) { dummy_class.new }
        let(:options) { { api_key: "123", param1: 1, param2: 2, try_conversion: true, extra_params: { x: 1 }, param3: 3, pure_hash: true } }

        describe ".available_keys" do
          let(:keys) { %i[api_key try_conversion relaxed_validation e extra_params sign pure_hash] }

          it { expect(dummy_instance.available_keys).to eq(keys) }
        end

        describe ".filter_options" do
          it {
            expect(dummy_instance.filter_options(options)).to eq({ api_key: "123", try_conversion: true, extra_params: { x: 1 }, pure_hash: true })
          }
        end

        describe ".create_query_params" do
          let(:dub) { dummy_instance.create_query_params(options) }

          before do
            def dummy_instance.query_params
              %i[api_key try_conversion extra_params e fsym tsyms pure_hash]
            end
          end

          context "when without block" do
            it "return another hash" do
              expect(dub.object_id).not_to eq(options.object_id)
            end

            it "key is camel case" do
              expect(dub).to have_key("apiKey")
            end
          end

          # rubocop:disable RSpec/MultipleMemoizedHelpers
          context "when with block" do
            let(:fsym) { "BTC" }
            let(:tsyms) { %w[ETH USD] }
            let(:dub) do
              dummy_instance.create_query_params(options) do |options|
                options["fsym"] = fsym
                options["tsyms"] = tsyms.join(",")
              end
            end

            it { expect(dub).to have_key("apiKey") }
            it { expect(dub["fsym"]).to eq(fsym) }
            it { expect(dub["tsyms"]).to eq(tsyms.join(",")) }
          end
          # rubocop:enable RSpec/MultipleMemoizedHelpers
        end
      end
    end
  end
end
