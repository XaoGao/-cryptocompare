# frozen_string_literal: true

module Utils
  RSpec.describe String do
    using Utils

    describe ".to_camel_case" do
      it { expect("hello_world".to_camel_case).to eq "helloWorld" }
      it { expect("Hello".to_camel_case).to eq "hello" }
    end
  end
end
