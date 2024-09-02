module IgdbClient
  module Query
    class Builder
      class InvalidArguments < StandardError; end

      ALL_FIELDS = "*".freeze

      def initialize(**opts)
        @exclude   = opts[:exclude]
        @fields    = opts[:fields] || ALL_FIELDS
        @id        = opts[:id]
        @limit     = opts[:limit]
        @search    = opts[:search]
        @sort_by   = opts[:sort_by]
        @sort_direction = opts[:sort_direction]

        perform_validations
      end

      def build
        params.values.map(&:field).join("")
      end

      def limit_to_one?
        params[:id].one? || params[:limit].one?
      end

      private

      def perform_validations
        errors = []

        if @id.present? && @search.present?
          errors << "Cannot combine ID with Search"
        end

        if @fields != "*" && @exclude.present?
          errors << "Cannot combine Fields with Exclude"
        end

        if errors.any?
          raise InvalidArguments, errors.join(", ")
        end

        show_redundant_argument_warning if @id.present? && @limit.present?
      end

      def params
        @params ||= build_params
      end

      def build_params
        {
          exclude: Fields::Exclude.new(@exclude),
          fields: Fields::Field.new(@fields),
          id: Fields::Id.new(@id),
          limit: Fields::Limit.new(@limit),
          search: Fields::Search.new(@search),
          sort: Fields::Sort.new(@sort_by, @sort_direction)
        }
      end

      def show_redundant_argument_warning
        "Warning: Specifying 'limit' with 'id' is redundant"
      end
    end
  end
end
