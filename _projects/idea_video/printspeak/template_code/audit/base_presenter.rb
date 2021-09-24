class BasePresenter
  attr_accessor :object

  def initialize(object, context = {})
    @object = object
    @_context = context
  end

  def shared_context
    @_shared_context ||= OpenStruct.new(@_context)
  end

  def present(_context)
    raise NotImplementedError, "You need to define 'present(context)' on #{self.class}"
  end

  def self.present(object, context = {})
    new(object, context).present(context)
  end

  def self.present_collection(objects, root: true, context: {})
  end

  def self.present_paginated_collection(objects, url_params:, context: {})
  end

  def self.present_dropdown(object_scope, properties: %i[id name], order_by: :created_at)
  end
end
