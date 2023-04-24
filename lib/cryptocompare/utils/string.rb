# frozen_string_literal: true

# Extension methods for string
module Cryptocompare
  module Utils
    refine String do
      def to_camel_case
        split("_")
          .map
          .with_index { |word, index| index.zero? ? word[0].downcase + word[1..] : word.capitalize }
          .join
      end
    end
  end
end
