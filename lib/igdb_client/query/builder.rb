module IgdbClient
  module Query
    class Builder
      class InvalidArguments < StandardError; end

      def initialize(fields: "*", id: nil, search: nil, limit: nil)
        raise InvalidArguments, "Cannot combine ID with Search" if id.present? && search.present?
        show_redundant_argument_warning if id.present? && limit.present?

        @params = {
          fields: Fields::Field.new(fields),
          id: Fields::Id.new(id),
          search: Fields::Search.new(search),
          limit: Fields::Limit.new(limit)
        }
      end

      def build
        @params.values.map(&:field).join("")
      end

      def limit_to_one?
        @params[:id].one? || @params[:limit].one?
      end

      private

      def show_redundant_argument_warning
        "Warning: Specifying 'limit' with 'id' is redundant"
      end
    end
  end
end
