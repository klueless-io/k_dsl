# def parameter_info(params)
#   parameter_info = params.map do |p|
#     name = p.length > 1 ? p[1] : ''

#     # name                - name of the parameter
#     # type                - type of the parameter
#     # signature_format    - ruby code format when used in a signature
#     # minimal_call_format - 

#     case p[0]
#     when :req
#       { name: name, type: :param_required, signature_format: "#{name}"      , minimal_call_format: "'#{name}'" }
#     when :opt
#       { name: name, type: :param_optional, signature_format: "#{name} = nil", minimal_call_format: "" }
#     when :rest
#       { name: name, type: :splat         , signature_format: "*#{name}"     , minimal_call_format: "" }
#     when :keyreq
#       { name: name, type: :key_required  , signature_format: "#{name}:"     , minimal_call_format: "#{name}: '#{name}'" }
#     when :key
#       { name: name, type: :key_optional  , signature_format: "#{name}: nil" , minimal_call_format: "" }
#     when :keyrest
#       { name: name, type: :double_splat  , signature_format: "**#{name}"    , minimal_call_format: "" }
#     when :block
#       { name: name, type: :block         , signature_format: "&#{name}"     , minimal_call_format: "" }
#     else
#       raise 'unknown type'
#     end
#   end
# end
