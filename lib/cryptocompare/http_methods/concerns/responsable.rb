# frozen_string_literal: true

module Cryptocompare
  module HttpMethods
    module Concerns
      module Responsable
        def return_response(faraday_response)
          if faraday_response.success?
            check_condition_pure_hash(faraday_response)
          else
            Failure.new(body: faraday_response, error: faraday_response.body)
          end
        end

        def check_condition_pure_hash(faraday_response)
          if options[:pure_hash]
            begin
              JSON.parse(faraday_response.body)
            rescue JSON::ParserError => _e
              # TODO: need add error log, a think about throw error up or return failure?
            end
          else
            Success.new(body: faraday_response)
          end
        end
      end
    end
  end
end
