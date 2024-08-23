# frozen_string_literal: true

class IgdbClient::ApiClient
  class InvalidEndpoint < StandardError; end
  def self.help
    new.help
  end

  def help
    "Available endpoints: #{all_endpoints.join(", ")}"
  end

  def get(path, raw_params = { fields: '*' })
    self.endpoint = path
    self.params = raw_params

    validate_endpoint
    response = make_post_request

    raise StandardError, "An error occurred: #{response.body}" unless response.success?

    response_body = JSON.parse(response.body, object_class: OpenStruct)
    params.keys.include?(:id) ? response_body.first : response_body
  end

  def search(path, query, raw_params = { fields: '*'})
    raw_params[:search] = '"' + query + '"'
    get(path.to_sym, raw_params)
  end

  private

  def validate_endpoint
    raise InvalidEndpoint, "'#{endpoint}' is not a recognized request." unless all_endpoints.include?(endpoint.to_sym)
    true
  end

  def make_post_request
    Faraday.post("#{api_base_url}/#{endpoint}") do |req|
      req.headers["Client-ID"] = twitch_oauth_client.id
      req.headers["Authorization"] = "Bearer #{twitch_oauth_client.access_token}"
      req.headers["Content-Type"] = "application/json"
      req.body = build_query
    end
  end

  def build_query
    query = mapped_params
    query.concat(["fields '*';"]) if missing_fields_parameter?
    query.join("")
  end

  def mapped_params
    params.map do |field, value|
      field == :id ? "where id = #{value};" : "#{field} #{value};"
    end
  end

  def missing_fields_parameter?
    params.keys.none? { |key| key.to_s.include?("fields") }
  end

  def api_base_url
    ENV.fetch("IGDB_API_BASE_URL")
  end

  def twitch_oauth_client
    @twitch_oauth_client ||= ::IgdbClient::Twitch::OauthClient.new
  end

  def all_endpoints
    ::IgdbClient::Constants::Endpoints::ALL
  end

  attr_accessor :endpoint, :params
end
