module IgdbClient
  module Query
    module Fields
      class Base
        attr_reader :field

        def initialize(value = "")
          @value = value
          @field = build

          validate_field
        end

        def build
          raise NoMethodError, "build must be implemented by subclasses."
        end

        protected

        def validate_field
          @field = "" unless @value.present?
        end
      end
    end
  end
end
