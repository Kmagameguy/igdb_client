# frozen_string_literal: true

require "test_helper"

module IgdbClient
  module Query
    module Fields
      class ExcludeTest < ::Minitest::Test

        describe IgdbClient::Query::Fields::Exclude do
          let(:subject) { IgdbClient::Query::Fields::Exclude }

          describe "#field" do
            it "returns a formatted string" do
              assert_equal subject.new("screenshots,websites").field, "exclude screenshots,websites;"
            end

            it "returns an empty string if no input is provided" do
              assert_empty subject.new.field
            end
          end
        end
      end
    end
  end
end
