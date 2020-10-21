# frozen_string_literal: true

module KDsl
  # File utilities
  module Util
    class << self
      attr_accessor :format
    end
  end
end

KDsl::Util.format = KDsl::TemplateRendering::HandlebarsFormatter
