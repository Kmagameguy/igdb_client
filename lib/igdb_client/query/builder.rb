module IgdbClient
  module Query
    class Builder
      class InvalidArguments < StandardError; end

      ALL_FIELDS = "*".freeze

      def initialize(**opts)
        @exclude   = opts[:exclude]
        @fields    = opts[:fields] || ALL_FIELDS
        @filter    = opts[:filter]
        @id        = opts[:id]
        @limit     = opts[:limit]
        @offset    = opts[:offset]
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

        if @id.present? && @offset.present?
          errors << "Cannot combine ID with Offset"
        end

        if @id.present? && @filter.present?
          errors << "Cannot combine ID with Filters"
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
          filter: Fields::Filter.new(@filter),
          id: Fields::Id.new(@id),
          limit: Fields::Limit.new(@limit),
          offset: Fields::Offset.new(@offset),
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
