module IgdbClient
  class Request
    class Error < StandardError; end

    def post(endpoint, query_builder)
      response =
        Faraday.post("#{api_base_url}/#{endpoint}") do |req|
          req.headers["Client-ID"] = twitch_oauth_client.id
          req.headers["Authorization"] = "Bearer #{twitch_oauth_client.access_token}"
          req.headers["Content-Type"] = "application/json"
          req.body = query_builder.build
        end

      handle_response(response)
    end

    private

    def handle_response(response)
      if response.success?
        JSON.parse(response.body, object_class: OpenStruct)
      else
        raise Error, "An error occurred: #{response.body}"
      end
    end

    def twitch_oauth_client
      @twitch_oauth_client ||= ::IgdbClient::Twitch::OauthClient.new
    end

    def api_base_url
      ENV.fetch("IGDB_API_BASE_URL")
    end

    attr_reader :endpoint, :query_builder
  end
end
