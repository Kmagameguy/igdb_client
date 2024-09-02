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
            assert_equal subject.new(id: 7).build, "fields *;where id = (7);"
          end

          it "creates a query with multiple ids" do
            assert_equal subject.new(id: [7, 13]).build, "fields *;where id = (7,13);"
          end

          it "creates a query with a selected id and a selected set of fields" do
            assert_equal subject.new(fields: "name,cover", id: 7).build, "fields name,cover;where id = (7);"
          end

          it "creates a query with a search term and default fields when not provided field arguments" do
            assert_equal subject.new(search: "Sherlock Holmes").build, "fields *;search \"Sherlock Holmes\";"
          end

          it "creates a query with a search term and a selected set of fields" do
            assert_equal subject.new(fields: "name,cover", search: "Sherlock Holmes").build, "fields name,cover;search \"Sherlock Holmes\";"
          end

          it "creates a query with a limit and default fields when not provided" do
            assert_equal subject.new(limit: 2).build, "fields *;limit 2;"
          end

          it "creates a query with a limit and a selected set of fields" do
            assert_equal subject.new(fields: "name,cover", limit: 2).build, "fields name,cover;limit 2;"
          end

          it "creates a query with a limit, search terms, and a default set of fields when not provided field arguments" do
            subject.any_instance.expects(:show_redundant_argument_warning).once
            assert_equal subject.new(id: 7, limit: 2).build, "fields *;where id = (7);limit 2;"
          end

          it "creates a query with a selected set of fields, an id, and a limit" do
            subject.any_instance.expects(:show_redundant_argument_warning).once
            assert_equal subject.new(fields: "name,cover", id: 7, limit: 2).build, "fields name,cover;where id = (7);limit 2;"
          end
        end

        describe "#limit_to_one?" do
          it "returns true if a limit option of 1 is supplied" do
            assert subject.new(limit: 1).limit_to_one?
          end

          it "returns true if a single ID is supplied" do
            assert subject.new(id: 4).limit_to_one?
            assert subject.new(id: [4]).limit_to_one?
          end

          it "returns true if for some reason multiple IDs but a limit of 1 is supplied" do
            assert subject.new(id: [5, 7], limit: 1).limit_to_one?
          end

          it "returns false if multiple IDs are supplied" do
            refute subject.new(id: [5, 7]).limit_to_one?
          end

          it "returns false if a limit greater than 1 is supplied" do
            refute subject.new(limit: 2).limit_to_one?
          end
        end
      end
    end
  end
end
