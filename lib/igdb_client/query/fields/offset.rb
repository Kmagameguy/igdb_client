module IgdbClient
  module Query
    module Fields
      class Offset < Base
        def build
          @field = "offset #{@value};"
        end
      end
    end
  end
end
