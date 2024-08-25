module IgdbClient
  module Query
    class Builder
      def initialize(fields: Field.new, id: Id.new, search: nil)
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
