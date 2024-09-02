module IgdbClient
  module Query
    module Fields
      class Id < ::IgdbClient::Query::Fields::Base
        def build
          joined_values = Array(@value).join(",")
          @field = "where id = (#{joined_values});"
        end

        def one?
          Array(@value).one?
        end
      end
    end
  end
end
