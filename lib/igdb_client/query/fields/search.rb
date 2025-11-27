# frozen_string_literal: true

module IgdbClient
  module Query
    module Fields
      class Search < ::IgdbClient::Query::Fields::Base
        def build
          @field = "search \"#{@value}\";"
        end
      end
    end
  end
end
