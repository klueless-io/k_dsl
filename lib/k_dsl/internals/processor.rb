# # frozen_string_literal: true

# # Module method stores single instance processor which can handle multiple incoming requests
# module KDsl
#   module Internals
#     # Processor is used to process incoming files
#     class Processor
#       # def file(file)
#       #   L.kv 'Process', file

#       #   L.kv 'Process DSL', file

#       #   content = File.read(file)

#       #   ruby_code(content, file, &block)

#       #   Klue.print
#       # end

#       # def code(ruby_code, source_file = nil)
#         # if Klue.register_instance.nil?

#         #   if block_given?
#         #     L.kv 'Register', 'started'
              
#         #     block.call

#         #     L.kv 'Register', 'finished'
#         #   end

#         # end

#         # begin
#         #   Klue.register_instance_or_default.process_code(:klue, ruby_code, source_file)
#         # rescue Klue::Dsl::DslNotFoundError, Klue::Dsl::DslNotFileRelatedError => dsl_error
#         #   L.info dsl_error.message

#         #   if block_given?
#         #     L.kv 'Re-Register', 'started'
              
#         #     Klue.reset
            
#         #     block.call

#         #     L.kv 'Re-Register', 'finished'
#         #   end
#         # rescue => exception
#         #   # Klue.debug
#         #   L.line
#         #   L.kv 'Klue - Error', exception.message      
#         #   L.line
#         #   # L.kv 'error', exception.backtrace
#         # end

#       # end
#     end
#   end
# end
