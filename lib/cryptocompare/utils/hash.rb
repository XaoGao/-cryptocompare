# frozen_string_literal: true

# Extension methods for hash
module Cryptocompare
  module Utils
    using Utils

    refine Hash do
      def transform_keys_to_camel_case
        transform_keys do |key|
          key.to_s.to_camel_case
        end
      end
    end
  end
end
