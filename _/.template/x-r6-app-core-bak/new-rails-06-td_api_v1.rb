require 'spec_helper'
require 'virtus'

module TestData

  # ---------------------------------------------
  # Setup Test data objects for API V1 controller
  # ---------------------------------------------

  # Convert each API JSON string into structs objects with named properties
  # Simple object to store JSON rows with well defined property names

  # All API actions will have a success/failure result
  class TdApiResult
    include Virtus.model

    def initialize(attributes)
      super(attributes)
    end

    attribute :success, Boolean
    attribute :message, String
    attribute :errors, Array[String]
  end

  # API index actions have a pagination object
  class TdApiPage
    include Virtus.model

    def initialize(attributes)
      super(attributes)
    end

    attribute :no, Integer
    attribute :size, Integer
    attribute :total, Integer
  end

  def map_td_api_page(page)
    return page.blank? ? nil : TdApiPage.new({
                                                 no: page['no'].to_i,
                                                 size: page['size'].to_i,
                                                 total: page['total'].to_i
                                             })
  end

  # API actions that return single result objects
  class TdApiOneRow
    include Virtus.model

    def initialize(attributes)
      super(attributes)
    end

    attribute :result, TdApiResult
    attribute :row, Object
  end

  def map_td_api_result(result)
    return result.blank? ? nil : TdApiResult.new({
                                                     success: result['success'],
                                                     message: result['message'],
                                                     errors: result['errors']
                                                 })
  end

  # API actions that return multiple result objects
  class TdApiManyRows
    include Virtus.model

    def initialize(attributes)
      super(attributes)
    end

    attribute :result, TdApiResult
    attribute :page, TdApiPage
    attribute :rows, Array[Object]
  end

end

