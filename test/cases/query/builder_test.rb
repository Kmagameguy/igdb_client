# frozen_string_literal: true

require "test_helper"

module IgdbClient
  module Query
    class BuilderTest < ::Minitest::Test
      describe IgdbClient::Query::Builder do
        let(:subject) { IgdbClient::Query::Builder }

        describe "#initialize" do
          it "raises an error when id and search terms are combined" do
            assert_raises(Builder::InvalidArguments) do
              subject.new(id: 7, search: "Sherlock Holmes")
            end
          end

          it "raises an error when fields and exclude terms are combined" do
            assert_raises(Builder::InvalidArguments) do
              subject.new(fields: "name", exclude: "screenshots")
            end
          end

          it "raises an error when id and offset terms are combined" do
            assert_raises(Builder::InvalidArguments) do
              subject.new(id: 7, offset: 2)
            end
          end

          it "raises an error when id and filter terms are combined" do
            assert_raises(Builder::InvalidArguments) do
              subject.new(id: 7, filter: "where rating >= 80")
            end
          end

          it "explains all the errors when multiple are present" do
            expected_error =
              "Cannot combine ID with Search, Cannot combine Fields with Exclude, Cannot combine ID with Offset"

            assert_raises(Builder::InvalidArguments, expected_error) do
              subject.new(id: 1103, search: "Super", fields: "name,cover", exclude: "name", offset: 7)
            end
          end
        end

        describe "#build" do
          it "creates a default query without arguments" do
            assert_equal "fields *;", subject.new.build
          end

          it "creates a query with a selected set of fields" do
            assert_equal "fields name,cover;", subject.new(fields: "name,cover").build
          end

          it "creates a query with a specific list of excluded fields" do
            assert_equal "exclude screenshots,websites;fields *;", subject.new(exclude: "screenshots,websites").build
          end

          it "creates a query with a selected id and default field query without field arguments" do
            assert_equal "fields *;where id = (7);", subject.new(id: 7).build
          end

          it "creates a query with multiple ids" do
            assert_equal "fields *;where id = (7,13);", subject.new(id: [7, 13]).build
          end

          it "creates a query with a selected id and a selected set of fields" do
            assert_equal "fields name,cover;where id = (7);", subject.new(fields: "name,cover", id: 7).build
          end

          it "creates a query with a search term and default fields when not provided field arguments" do
            assert_equal "fields *;search \"Sherlock Holmes\";", subject.new(search: "Sherlock Holmes").build
          end

          it "creates a query with a search term and a selected set of fields" do
            assert_equal "fields name,cover;search \"Sherlock Holmes\";",
                         subject.new(fields: "name,cover", search: "Sherlock Holmes").build
          end

          it "creates a query with a limit and default fields when not provided" do
            assert_equal "fields *;limit 2;", subject.new(limit: 2).build
          end

          it "creates a query with a limit and a selected set of fields" do
            assert_equal "fields name,cover;limit 2;", subject.new(fields: "name,cover", limit: 2).build
          end

          it "creates a query with a limit, search terms, and default fields when not provided field arguments" do
            subject.any_instance.expects(:show_redundant_argument_warning).once

            assert_equal "fields *;where id = (7);limit 2;", subject.new(id: 7, limit: 2).build
          end

          it "creates a query with a selected set of fields, an id, and a limit" do
            subject.any_instance.expects(:show_redundant_argument_warning).once

            assert_equal "fields name,cover;where id = (7);limit 2;",
                         subject.new(fields: "name,cover", id: 7, limit: 2).build
          end

          it "creates a query with a specific sorting order" do
            assert_equal(
              "fields name,cover,aggregated_rating;where id = (7,12);sort aggregated_rating desc;",
              subject.new(fields: "name,cover,aggregated_rating", id: [7, 12], sort_by: "aggregated_rating",
                          sort_direction: :desc).build
            )
          end
        end

        describe "#limit_to_one?" do
          it "returns true if a limit option of 1 is supplied" do
            assert_predicate subject.new(limit: 1), :limit_to_one?
          end

          it "returns true if a single ID is supplied" do
            assert_predicate subject.new(id: 4), :limit_to_one?
            assert_predicate subject.new(id: [4]), :limit_to_one?
          end

          it "returns true if for some reason multiple IDs but a limit of 1 is supplied" do
            assert_predicate subject.new(id: [5, 7], limit: 1), :limit_to_one?
          end

          it "returns false if multiple IDs are supplied" do
            refute_predicate subject.new(id: [5, 7]), :limit_to_one?
          end

          it "returns false if a limit greater than 1 is supplied" do
            refute_predicate subject.new(limit: 2), :limit_to_one?
          end
        end
      end
    end
  end
end
