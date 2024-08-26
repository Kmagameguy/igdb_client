module IgdbClient
  module Query
    module Fields
      class Field < ::IgdbClient::Query::Fields::Base
        def build
          @field = "fields #{@value};"
        end

        protected

        def validate_field
          @field = "fields '*';" unless @value.present?
        end
      end
    end
  end
end
