module IgdbClient
  module Query
    module Fields
      class IdTest < ::Minitest::Test
        describe IgdbClient::Query::Fields::Id do
          let(:subject) { IgdbClient::Query::Fields::Id }

          describe "#field" do
            it "returns a formatted string" do
              assert_equal subject.new(12).field, "where id = 12;"
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
