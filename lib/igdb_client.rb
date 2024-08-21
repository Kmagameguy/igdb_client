require "ostruct"
require "json"
require "faraday"
require "active_support/all"

module IgdbClient
  autoload :ApiClient, "igdb_client/api_client"
  module Constants
    autoload :Endpoints, "igdb_client/constants/endpoints"
  end
  module Twitch
    autoload :OauthClient, "igdb_client/twitch/oauth_client"
  end
end
