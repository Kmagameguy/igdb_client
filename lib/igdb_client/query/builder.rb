module IgdbClient
  module Query
    class Builder
      class InvalidArguments < StandardError; end

      ALL_FIELDS = "*".freeze

      def initialize(**opts)
        @fields  = opts[:fields] || ALL_FIELDS
        @exclude = opts[:exclude]
        @id      = opts[:id]
        @search  = opts[:search]
        @limit   = opts[:limit]

        raise InvalidArguments, "Cannot combine ID with Search" if @id.present? && @search.present?
        raise InvalidArguments, "Cannot combine Fields with Exclude" if @fields != "*" && @exclude.present?
        show_redundant_argument_warning if @id.present? && @limit.present?
      end

      def build
        params.values.map(&:field).join("")
      end

      def limit_to_one?
        params[:id].one? || params[:limit].one?
      end

      private

      def params
        @params ||= build_params
      end

      def build_params
        {
          fields: Fields::Field.new(@fields),
          exclude: Fields::Exclude.new(@exclude),
          id: Fields::Id.new(@id),
          search: Fields::Search.new(@search),
          limit: Fields::Limit.new(@limit)
        }
      end

      def show_redundant_argument_warning
        "Warning: Specifying 'limit' with 'id' is redundant"
      end
    end
  end
end
