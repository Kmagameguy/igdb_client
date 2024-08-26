module IgdbClient
  module Query
    class Builder
      class InvalidArguments < StandardError; end

      def initialize(fields: "*", id: nil, search: nil)
        raise InvalidArguments, "Cannot combine ID with Search" if id.present? && search.present?

        @params = {
          fields: Fields::Field.new(fields),
          id: Fields::Id.new(id),
          search: Fields::Search.new(search)
        }
      end

      def build
        @params.values.map(&:field).join("")
      end

      def search_by_id?
        @params[:id].field.present?
      end
    end
  end
end
