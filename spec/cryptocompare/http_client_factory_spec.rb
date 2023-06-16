# frozen_string_literal: true

module Cryptocompare
  RSpec.describe HttpClientFactory do
    describe ".create" do
      let(:factory) { described_class.new }
      let(:connector) { factory.create }

      describe ".create" do
        it { expect(connector).to be_a(Faraday::Connection) }
        it { expect(connector.headers["Content-Type"]).to eq("application/json") }
      end
    end
  end
end
