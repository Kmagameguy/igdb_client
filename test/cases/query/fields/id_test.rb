# frozen_string_literal: true

require "test_helper"

module IgdbClient
  module Query
    module Fields
      class IdTest < ::Minitest::Test
        describe IgdbClient::Query::Fields::Id do
          let(:subject) { IgdbClient::Query::Fields::Id }

          describe "#field" do
            it "returns a formatted string" do
              assert_equal subject.new(12).field, "where id = (12);"
            end

            it "accepts arrays as arguments" do
              assert_equal subject.new([12, 33]).field, "where id = (12,33);"
            end

            it "returns an empty value when no argument is provided" do
              assert_empty subject.new.field
            end
          end

          describe "#one?" do
            it "returns true if a single value is provided" do
              assert subject.new(12).one?
              assert subject.new([12]).one?
            end

            it "returns false if more than a single value is provided" do
              refute subject.new([3, 12]).one?
            end
          end
        end
      end
    end
  end
end
