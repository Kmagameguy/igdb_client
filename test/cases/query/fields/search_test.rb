# frozen_string_literal: true

require "test_helper"

module IgdbClient
  module Query
    module Fields
      class SearchTest < ::Minitest::Test
        describe IgdbClient::Query::Fields::Search do
          let(:subject) { IgdbClient::Query::Fields::Search }

          describe "#field" do
            it "returns a formatted string" do
              assert_equal subject.new("Sherlock Holmes").field, "search \"Sherlock Holmes\";"
            end

            it "returns an empty value when no argument is provided" do
              assert_empty subject.new.field
            end
          end
        end
      end
    end
  end
end
