module IgdbClient
  module Query
    module Fields
      class Filter < Base
        def build
          @field = "#{@value};"
        end
      end
    end
  end
end
