# frozen_string_literal: true

require "test_helper"

module IgdbClient
  module Query
    module Fields
      class OffsetTest < ::Minitest::Test
        describe IgdbClient::Query::Fields::Offset do
          let(:subject) { IgdbClient::Query::Fields::Offset }
          describe "#build" do
            it "returns a formatted string" do
              assert subject.new(33).field, "offset 33;"
            end
          end
        end
      end
    end
  end
end
