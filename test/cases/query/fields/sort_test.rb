# frozen_string_literal: true

require "test_helper"

module IgdbClient
  module Query
    module Fields
      class SortTest < ::Minitest::Test
        describe IgdbClient::Query::Fields::Sort do
          let(:subject) { IgdbClient::Query::Fields::Sort }

          describe "#field" do
            it "returns a formatted string with a default sort order when one is not provided" do
              assert_equal "sort aggregated_rating asc;", subject.new("aggregated_rating").field
            end

            it "accepts a second parameter to inform the sort order" do
              assert_equal "sort aggregated_rating desc;", subject.new("aggregated_rating", :desc).field
            end

            it "raises an error if more than one field is provided to the sort argument" do
              assert_raises(IgdbClient::Query::Fields::Sort::InvalidValue) do
                subject.new("aggregated_rating,name").field
              end
            end

            it "raises an error if the sort order parameter is not valid" do
              sort_me = :sort_me
              assert_raises(IgdbClient::Query::Fields::Sort::InvalidOrder,
                            "Accepted order directions are ':asc' and ':desc'.  Couldn't understand #{sort_me}") do
                subject.new("aggregated_rating", sort_me).field
              end
            end
          end
        end
      end
    end
  end
end
