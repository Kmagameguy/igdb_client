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
        end
        describe "#build" do
          it "creates a default query without arguments" do
            assert_equal subject.new.build, "fields *;"
          end

          it "creates a query with a selected set of fields" do
            assert_equal subject.new(fields: "name,cover").build, "fields name,cover;"
          end

          it "creates a query with a selected id and default field query without field arguments" do
            assert_equal subject.new(id: 7).build, "fields *;where id = 7;"
          end

          it "creates a query with a selected id and a selected set of fields" do
            assert_equal subject.new(fields: "name,cover", id: 7).build, "fields name,cover;where id = 7;"
          end

          it "creates a query with a search term and default fields when not provided field arguments" do
            assert_equal subject.new(search: "Sherlock Holmes").build, "fields *;search \"Sherlock Holmes\";"
          end

          it "creates a query with a search term and a selected set of fields" do
            assert_equal subject.new(fields: "name,cover", search: "Sherlock Holmes").build, "fields name,cover;search \"Sherlock Holmes\";"
          end
        end

        describe "#search_by_id?" do
          it "returns true when an 'id' argument is used" do
            assert subject.new(id: 7).search_by_id?
          end

          it "returns true when fields and id arguments are provided" do
            assert subject.new(fields: "name,cover", id: 7).search_by_id?
          end

          it "returns false when no arguments are provided" do
            refute subject.new.search_by_id?
          end

          it "returns false when the only provided argument are fields" do
            refute subject.new(fields: "name,cover").search_by_id?
          end

          it "returns false when the only provided argument is a search term" do
            refute subject.new(search: "Sherlock Holmes").search_by_id?
          end

          it "returns false when fields and a search term are provided without an id" do
            refute subject.new(fields: "name,cover", search: "Sherlock Holmes").search_by_id?
          end
        end
      end
    end
  end
end
