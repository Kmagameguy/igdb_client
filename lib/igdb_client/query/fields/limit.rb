module IgdbClient
  module Query
    module Fields
      class Limit < ::IgdbClient::Query::Fields::Base
        def build
          @field = "limit #{@value};"
        end

        def one?
          @value.present? && @value == 1
        end
      end
    end
  end
end
