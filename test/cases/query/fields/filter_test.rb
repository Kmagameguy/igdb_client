# frozen_string_literal: true

require "test_helper"

module IgdbClient
  module Query
    module Fields
      class FilterText < ::Minitest::Test
        describe IgdbClient::Query::Fields::Filter do
          let(:subject) { IgdbClient::Query::Fields::Filter }

          describe "#field" do
            it "appends a semicolon but otherwise does not validate the input" do
              assert_equal subject.new("where rating >= 80").field, "where rating >= 80;"
            end
          end
        end
      end
    end
  end
end
