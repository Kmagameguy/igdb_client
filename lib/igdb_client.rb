require "ostruct"
require "json"
require "faraday"
require "active_support/all"

module IgdbClient
  module Twitch
    autoload :OauthClient, "igdb_client/twitch/oauth_client"
  end
end
