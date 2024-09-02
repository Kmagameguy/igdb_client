module IgdbClient
  module Query
    module Fields
      class Limit < ::IgdbClient::Query::Fields::Base
        class TooManyRecordsError < StandardError; end

        # IGDB enforces a maximum limit of 500 records per query.
        # Let's enforce that here, too.
        MAX_LIMIT = 500

        def build
          @field = "limit #{@value};"
        end

        def one?
          @value.present? && @value == 1
        end

        protected

        def validate_field
          @field = "" unless @value.present?

          if @value.to_i > MAX_LIMIT
            raise TooManyRecordsError, "Max limit is #{MAX_LIMIT}."
          end
        end
      end
    end
  end
end
