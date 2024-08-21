require "bundler"
require "dotenv"
Bundler.require :development, :test

require "igdb_client"
require "minitest/autorun"
require "minitest/spec"
require "minitest/stub_const"
require "mocha/minitest"
require "vcr"

Dotenv.load(".env.test.local", ".env.test", ".env.local", ".env")

Bundler.setup(:default, :test)

VCR.configure do |vcr|
  vcr.cassette_library_dir = "test/cassettes"
  vcr.hook_into :webmock
  vcr.allow_http_connections_when_no_cassette = true
  vcr.default_cassette_options = {
    record: :once,
    match_requests_on: [:method, :host, :path, :query]
  }
  vcr.filter_sensitive_data("<TWITCH_API_CLIENT_ID>")     { ENV["TWITCH_API_CLIENT_ID"] }
  vcr.filter_sensitive_data("<TWITCH_API_CLIENT_SECRET>") { ENV["TWITCH_API_CLIENT_SECRET"] }
end
