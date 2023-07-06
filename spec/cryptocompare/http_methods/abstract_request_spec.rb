# frozen_string_literal: true

module Cryptocompare
  module HttpMethods
    RSpec.describe AbstractRequest do
      subject(:request) { described_class.new }

      describe ".perform" do
        it { expect { request.perform(nil) }.to raise_error(NotImplementedError) }
      end

      describe ".perform!" do
        it { expect { request.perform!(nil) }.to raise_error(NotImplementedError) }
      end
    end
  end
end
