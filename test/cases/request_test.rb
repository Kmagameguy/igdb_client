module IgdbClient
  class RequestTest < ::Minitest::Test
    describe IgdbClient::Request do
      let(:subject) { IgdbClient::Request }
      let(:query_builder) { IgdbClient::Query::Builder.new(fields: "name", limit: 1) }

      describe "#post" do
        it "returns an array of OpenStruct objects from the post request" do
          VCR.use_cassette("request_post") do
            response = subject.new.post(:games, query_builder)
            assert response.is_a?(Array)
            assert response.first.is_a?(OpenStruct)
          end
        end

        it "raises an error if the request encountered a problem" do
          Faraday::Response.any_instance.stubs(:success?).returns(false)
          Faraday.stubs(:post).returns(Faraday::Response.new)

          assert_raises(IgdbClient::Request::Error) do
            subject.new.post(:games, query_builder)
          end
        end
      end
    end
  end
end
