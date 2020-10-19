module Query
  class QuerySortDo
    include Virtus.model

    attribute :field, String
    attribute :direction, String, :default => 'asc'
    attribute :sort, String, :reader => :private # The reader is private so it does not appear in the JSON document, so sort delegates to direction is is helpful with the

    def field=(field)
      super(field.downcase)
    end

    def direction=(direction)
      value = direction.downcase

      value = 'asc' if !['asc', 'desc'].include?(value)

      super(value)
    end

    def sort=(sort)
      self.direction = sort
      super(sort)
    end

  end
end