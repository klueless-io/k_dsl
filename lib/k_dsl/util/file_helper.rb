# frozen_string_literal: true

module KDsl
  module Util
    # Simple File utilities
    class FileHelper
      def self.expand_path(filename, base_path)
        if pathname_absolute?(filename)
          filename
        elsif filename.start_with?('~/')
          File.expand_path(filename)
        else
          File.expand_path(filename, base_path)
        end
      end

      def self.pathname_absolute?(pathname)
        Pathname.new(pathname).absolute?
      end
    end
  end
end
