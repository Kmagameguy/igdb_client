# frozen_string_literal: true

module IgdbClient
  module Query
    module Fields
      class Exclude < ::IgdbClient::Query::Fields::Base
        def build
          @field = "exclude #{@value};"
        end
      end
    end
  end
end
