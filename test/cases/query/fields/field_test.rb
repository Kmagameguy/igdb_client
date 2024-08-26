require "test_helper"

module IgdbClient
  module Query
    module Fields
      class FieldTest < ::Minitest::Test
        describe IgdbClient::Query::Fields::Field do
          let(:subject) { IgdbClient::Query::Fields::Field }
          describe "#field" do
            it "returns a formatted string" do
              assert_equal subject.new("name").field, "fields name;"
            end

            it "returns all fields if no input is provided" do
              assert_equal subject.new.field, "fields '*';"
            end
          end
        end
      end
    end
  end
end
