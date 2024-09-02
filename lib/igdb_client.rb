require "ostruct"
require "json"
require "faraday"
require "active_support/all"

module IgdbClient
  autoload :Api,      "igdb_client/api"
  autoload :Endpoint, "igdb_client/endpoint"
  autoload :Request,  "igdb_client/request"

  module Constants
    autoload :Endpoints, "igdb_client/constants/endpoints"
  end

  module Query
    autoload :Builder,   "igdb_client/query/builder"

    module Fields
      autoload :Base,    "igdb_client/query/fields/base"
      autoload :Exclude, "igdb_client/query/fields/exclude"
      autoload :Field,   "igdb_client/query/fields/field"
      autoload :Id,      "igdb_client/query/fields/id"
      autoload :Limit,   "igdb_client/query/fields/limit"
      autoload :Search,  "igdb_client/query/fields/search"
      autoload :Sort,    "igdb_client/query/fields/sort"
    end
  end

  module Twitch
    autoload :OauthClient, "igdb_client/twitch/oauth_client"
  end
end
