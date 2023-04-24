# frozen_string_literal: true

module Utils
  RSpec.describe Hash do
    using Utils

    describe ".transform_keys_to_camel_case" do
      subject(:hash) { { House: "Kizhakkethara", house_no: 123, locality: "India" } }

      it do
        expect(hash.transform_keys_to_camel_case).to eq(
          { "house" => "Kizhakkethara", "houseNo" => 123, "locality" => "India" }
        )
      end
    end
  end
end
