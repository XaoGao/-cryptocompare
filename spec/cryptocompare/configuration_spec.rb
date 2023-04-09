# frozen_string_literal: true

module Cryptocompare
  RSpec.describe Configuration do
    let(:dummy_class) { Class.new { extend Configuration } }

    describe "#configuration" do
      before do
        dummy_class.configuration do |config|
          config.api_key = "api_key"
          config.try_conversion = "try_conversion"
          config.relaxed_validation = "relaxed_validation"
          config.e = "e"
          config.extra_params = "extra_params"
          config.sign = "sign"
          config.pure_hash = "pure_hash"
        end
      end

      it { expect(dummy_class.api_key).to eq("api_key") }
      it { expect(dummy_class.try_conversion).to eq("try_conversion") }
      it { expect(dummy_class.relaxed_validation).to eq("relaxed_validation") }
      it { expect(dummy_class.e).to eq("e") }
      it { expect(dummy_class.extra_params).to eq("extra_params") }
      it { expect(dummy_class.sign).to eq("sign") }
      it { expect(dummy_class.pure_hash).to eq("pure_hash") }
    end
  end
end
