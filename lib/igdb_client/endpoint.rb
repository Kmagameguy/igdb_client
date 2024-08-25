module IgdbClient
  class Endpoint
    class Invalid < StandardError; end

    def self.validate(path)
      new.validate(path)
    end

    def validate(path)
      path = path&.to_sym || :nil

      if unknown_endpoint?(path.to_sym)
        raise Invalid, "\"#{path}\" is not a recognized request."
      end

      path
    end

    private

    def unknown_endpoint?(item)
      !all_endpoints.include?(item)
    end

    def all_endpoints
      ::IgdbClient::Constants::Endpoints::ALL
    end
  end
end
