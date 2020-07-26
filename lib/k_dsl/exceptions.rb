# frozen_string_literal: true

module KDsl
  class << self
    attr_accessor :logger
  end

  # A general KDsl exception
  class Error < StandardError; end

  # Raised when tyring to create a DSL with invalid type
  class InvalidTypeError < KDsl::Error; end
end
