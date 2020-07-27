# frozen_string_literal: true

# Module method stores single instance processor which can handle multiple incoming requests
module KDsl
  module Internals
    # Processor is used to process incoming files
    class Processor
      def file(file)
        L.kv 'Process', file
      end
    end
  end
end
