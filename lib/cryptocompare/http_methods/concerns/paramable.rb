# frozen_string_literal: true

module Cryptocompare
  module HttpMethods
    module Concerns
      module Paramable
        using Utils

        # List of all params query names
        def available_keys
          %i[api_key try_conversion relaxed_validation e extra_params sign pure_hash].freeze
        end

        def query_params
          raise NotImplementedError "'query_params' must be implemented in #{self.class}"
        end

        def filter_options(options)
          options.filter { |key, _| available_keys.include? key }
        end

        def create_query_params(options, &block)
          dub = options.clone
                       .filter { |key, _| query_params.include? key }
          yield(dub) if block
          dub.transform_keys_to_camel_case
        end
      end
    end
  end
end
