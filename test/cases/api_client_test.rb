require "test_helper"

class IgdbClient::ApiClientTest < ::Minitest::Test
  describe IgdbClient::ApiClient do
    let(:subject) { IgdbClient::ApiClient }
    let(:all_endpoints) { IgdbClient::Constants::Endpoints::ALL}

    describe ".help" do
      it "is an alias for #help and presents helpful usage information" do
        assert_equal "Available endpoints: #{all_endpoints.join(', ')}", subject.help
      end
    end

    describe "#help" do
      it "presents helpful usage information" do
        assert_match "Available endpoints: #{all_endpoints.join(', ')}", subject.new.help
      end
    end

    describe "#get" do
      it "can fetch data from the IGDB" do
        VCR.use_cassette("list_of_game_names") do
          response = subject.new.get(:games, { fields: "name" })
          sample_game = response.sample

          assert_equal 10, response.length
          assert sample_game.id.present?
          assert sample_game.name.present?
        end
      end

      it "raises an error if the requested endpoint is not valid" do
        assert_raises(subject::InvalidEndpoint, "'invalid_endpoint' is not a recognized request.") do
          subject.new.get(:invalid_endpoint)
        end
      end

      it "can search for things" do
        VCR.use_cassette("game_search") do
          response = subject.new.get(:games, search: "Half-Life 2", fields: "name")
          sample_game = response.sample

          assert sample_game.id.present?
          assert_match "Half-Life 2", sample_game.name
        end
      end
    end
  end
end
