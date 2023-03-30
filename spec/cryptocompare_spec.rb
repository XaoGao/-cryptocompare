# frozen_string_literal: true

RSpec.describe Cryptocompare do
  it "has a version number" do
    expect(Cryptocompare::VERSION).not_to be_nil
  end
end
