module IgdbClient
  module Query
    module Fields
      class Limit < ::IgdbClient::Query::Fields::Base
        def build
          @field = "limit #{@value};"
        end
      end
    end
  end
end
