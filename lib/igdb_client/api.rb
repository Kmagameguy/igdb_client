module IgdbClient
  class Api
    def self.help
      new.help
    end

    def help
      "Available endpoints: #{Constants::Endpoints::ALL.join(", ")}"
    end

    def get(path, fields: "*", id: nil, search: nil, limit: nil)
      self.query_builder =
        Query::Builder.new(
          fields: fields,
          id: id,
          search: search,
          limit: limit)

      self.endpoint = Endpoint.validate(path)

      Request.new.post(endpoint, query_builder)
    end

    private

    attr_accessor :endpoint, :query_builder
  end
end
