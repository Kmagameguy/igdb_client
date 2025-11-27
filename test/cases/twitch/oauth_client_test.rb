require "test_helper"

class IgdbClient::Twitch::OauthClientTest < Minitest::Test
  describe IgdbClient::Twitch::OauthClient do
    let(:subject) { IgdbClient::Twitch::OauthClient }

    describe "#access_token" do
      it "can retrieve an access token from Twitch.tv" do
        VCR.use_cassette("get_twitch_access_token") do
          assert !!subject.new.access_token
        end
      end

      it "raises an error when the connection to twitch fails" do
        Faraday.stubs(:post).returns(Faraday::Response.new(status: 501, body: "error"))

        assert_raises(subject::Error) do
          subject.new.access_token
        end
      end
    end

    describe "#id" do
      it "exposes the client_id from .env" do
        assert !!subject.new.id
      end
    end
  end
end
