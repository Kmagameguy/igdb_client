# frozen_string_literal: true

require "test_helper"

module IgdbClient
  class EndpointTest < ::Minitest::Test
    describe IgdbClient::Endpoint do
      let(:subject) { IgdbClient::Endpoint }
      let(:error) { IgdbClient::Endpoint::Invalid }

      describe ".validate" do
        it "can validate a real endpoint" do
          assert_equal :games, subject.validate(:games)
        end

        it "raises an error if an endpoint does not exist" do
          assert_raises(error) do
            subject.validate(:not_a_real_endpoint)
          end
        end
      end

      describe "#validate" do
        it "can validate a real endpoint" do
          assert_equal :games, subject.new.validate(:games)
        end

        it "raises an error if an endpoint does not exist" do
          assert_raises(error) do
            subject.validate(:not_a_real_endpoint)
          end
        end
      end
    end
  end
end
