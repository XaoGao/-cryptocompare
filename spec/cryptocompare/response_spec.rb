# frozen_string_literal: true

module Cryptocompare
  RSpec.describe Response do
    let(:success_response) { described_class.new(status: true, value: nil, error: nil) }
    let(:failure_response) { described_class.new(status: false, value: nil, error: nil) }

    describe ".success?" do
      it { expect(success_response.success?).to be true }
      it { expect(success_response.failure?).to be false }
    end

    describe ".failure?" do
      it { expect(failure_response.success?).to be false }
      it { expect(failure_response.failure?).to be true }
    end
  end
end
