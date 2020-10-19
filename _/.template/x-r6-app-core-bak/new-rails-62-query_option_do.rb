module Query
  class QueryOptionDo
    include Virtus.model

    def initialize(hash)
      super(hash)

      if (self.page.present? && self.page.size.present? && self.page.size == -1)
        self.page.size = 10000
      end
    end

    attribute :page, QueryPageDo, :default => QueryPageDo.new
    attribute :filter, Hash
    attribute :layout, String, :default => 'default'
    attribute :sort, Array[QuerySortDo]

  end
end