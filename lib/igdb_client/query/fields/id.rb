module IgdbClient
  module Query
    module Fields
      class Id < ::IgdbClient::Query::Fields::Base
        def build
          @field = "where id = #{@value};"
        end
      end
    end
  end
end
