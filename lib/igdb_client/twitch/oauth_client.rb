# frozen_string_literal: true

module IgdbClient
  module Twitch
    class OauthClient
      class Error < StandardError; end

      def initialize
        @token_expiration_date = nil
        @access_token = nil
      end

      def access_token
        return @access_token unless @access_token.nil? || Time.current >= token_expiration_date

        response = Faraday.post(oauth_url.to_s) do |f|
          f.headers["Content-Type"] = "application/json"
          f.body = request_body
        end

        raise Error, "Couldn't retrieve Twitch access token" unless response.success?

        token_data = JSON.parse(response.body, object_class: OpenStruct)
        self.token_expiration_date = Time.current + token_data.expires_in
        @access_token = token_data.access_token
      end

      def id
        ENV.fetch("TWITCH_API_CLIENT_ID")
      end

      private

      def request_body
        {
          client_id: id,
          client_secret: secret,
          grant_type: "client_credentials"
        }.to_json
      end

      def secret
        ENV.fetch("TWITCH_API_CLIENT_SECRET")
      end

      def oauth_url
        ENV.fetch("TWITCH_API_OAUTH_URL")
      end

      attr_accessor :token_expiration_date
    end
  end
end
