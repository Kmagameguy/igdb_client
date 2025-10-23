module IgdbClient
  class Endpoint
    class Invalid < StandardError; end

    # Convenience method to avoid having
    # to type the "new" keyword any time
    # this class is used.
    def self.validate(path)
      new.validate(path)
    end

    def validate(path)
      path = path&.to_sym || :nil

      if unknown_endpoint?(path.to_sym)
        raise Invalid, "\"#{path}\" is not a recognized request."
      end

      if deprecated_endpoint?(path.to_sym)
        puts "DEPRECATION WARNING: age_rating_content_descriptions endpoint is deprecated."
        puts "Please use age_rating_content_descriptions_v2 instead."
        puts "This endpoint will be removed in a future update of the IGDB Client."
        puts "Set SUPPRESS_DEPRECATION_WARNINGS to \"true\" to silence these notifications."
      end

      path
    end

    private

    def unknown_endpoint?(item)
      !all_endpoints.include?(item)
    end

    def deprecated_endpoint?(item)
      return false if ENV["SUPPRESS_DEPRECATION_WARNINGS"] == "true"

      item == IgdbClient::Constants::Endpoints::AGE_RATING_CONTENT_DESCRIPTIONS
    end

    def all_endpoints
      ::IgdbClient::Constants::Endpoints::ALL
    end
  end
end
