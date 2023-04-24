# frozen_string_literal: true

# Extension method for string
module Utils
  refine String do
    def to_camel_case
      split("_")
        .map
        .with_index do |word, index|
          index.zero? ? word[0].downcase + word[1..] : word.capitalize
        end.join
    end
  end
end
