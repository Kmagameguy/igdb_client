module IgdbClient
  module Query
    module Fields
      class LimitTest < ::Minitest::Test
        describe IgdbClient::Query::Fields::Limit do
          let(:subject) { IgdbClient::Query::Fields::Limit }

          describe "#field" do
            it "returns a formatted string" do
              assert_equal subject.new(2).field, "limit 2;"
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
