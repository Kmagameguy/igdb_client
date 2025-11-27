# frozen_string_literal: true

require "test_helper"

module IgdbClient
  module Query
    module Fields
      class FieldTest < ::Minitest::Test
        describe IgdbClient::Query::Fields::Field do
          let(:subject) { IgdbClient::Query::Fields::Field }
          describe "#field" do
            it "returns a formatted string" do
              assert_equal "fields name;", subject.new("name").field
            end

            it "returns all fields if no input is provided" do
              assert_equal "fields '*';", subject.new.field
            end
          end
        end
      end
    end
  end
end
