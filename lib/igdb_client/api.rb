# frozen_string_literal: true

module IgdbClient
  class Api
    def self.help
      new.help
    end

    def help
      "Available endpoints: #{Constants::Endpoints::ALL.join(', ')}"
    end

    def get(path, **opts)
      self.query_builder = Query::Builder.new(**opts)

      self.endpoint = Endpoint.validate(path)

      response = request.post(endpoint, query_builder)
      query_builder.limit_to_one? ? response.first : response
    end

    private

    def request
      @request ||= Request.new
    end

    attr_accessor :endpoint, :query_builder
  end
end
