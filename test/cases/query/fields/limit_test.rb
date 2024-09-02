module IgdbClient
  module Query
    module Fields
      class LimitTest < ::Minitest::Test
        describe IgdbClient::Query::Fields::Limit do
          let(:subject) { IgdbClient::Query::Fields::Limit }
          let(:limit) { subject::MAX_LIMIT }

          describe "#field" do
            it "returns a formatted string" do
              assert_equal subject.new(limit).field, "limit #{limit};"
            end

            it "returns an empty value when no argument is provided" do
              assert_empty subject.new.field
            end

            it "raises an error if the limit specified is more than the maximum allowed" do
              assert_raises(IgdbClient::Query::Fields::Limit::TooManyRecordsError, "Max limit is #{limit + 1}.") do
                subject.new(limit + 1).field
              end
            end
          end

          describe "#one?" do
            it "returns true if the value is 1" do
              assert subject.new(1).one?
            end

            it "returns false if the value is anything other than 1" do
              refute subject.new(0).one?
              refute subject.new(-1).one?
              refute subject.new(2).one?
            end
          end
        end
      end
    end
  end
end
