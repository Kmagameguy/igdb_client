# frozen_string_literal: true

module IgdbClient
  module Query
    module Fields
      # Don't inherit from base since this sort requires two input parameters
      class Sort
        class InvalidValue < StandardError; end
        class InvalidOrder < StandardError; end

        attr_reader :field

        def initialize(value = "", order = nil)
          @value = value.to_s
          @order = order || :asc
          @field = build

          validate_field
        end

        def build
          @field = "sort #{@value} #{@order};"
        end

        protected

        def validate_field
          raise InvalidValue if (@value.include?(",") || @value.is_a?(Array))
          @field = "" unless @value.present?

          validate_order
        end

        def validate_order
          if invalid_order_direction?
            raise InvalidOrder, "Accepted order directions are ':asc' and ':desc'.  Couldn't understand #{@order}."
          end
        end

        def invalid_order_direction?
          !valid_order_direction?
        end

        def valid_order_direction?
          [:asc, :desc].include?(@order)
        end
      end
    end
  end
end
