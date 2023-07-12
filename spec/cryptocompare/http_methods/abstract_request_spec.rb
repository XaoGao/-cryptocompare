# frozen_string_literal: true

module Cryptocompare
  module HttpMethods
    RSpec.describe AbstractRequest do
      subject(:request) { described_class.new }

      describe ".perform" do
        it { expect { request.perform(nil) }.to raise_error(NotImplementedError) }
      end

      describe ".perform!" do
        context "when success result" do
          # rubocop:disable RSpec/SubjectStub
          before do
            allow(request)
              .to receive(:perform)
              .and_return(Cryptocompare::Success.new(value: "some value"))
          end
          # rubocop:enable RSpec/SubjectStub

          it "return success object" do
            result = request.perform!(fsym: "UTC", tsyms: %w[USD])
            expect(result.class).to eq(Cryptocompare::Success)
          end
        end

        context "when failure result" do
          # rubocop:disable RSpec/SubjectStub
          before do
            allow(request)
              .to receive(:perform)
              .and_return(Cryptocompare::Failure.new(value: "some value", error: "some error"))
          end
          # rubocop:enable RSpec/SubjectStub

          it "raise NotSuccessful" do
            expect { request.perform!(fsym: "UTC", tsyms: %w[USD]) }.to raise_error(NotSuccessful)
          end
        end
      end
    end
  end
end
