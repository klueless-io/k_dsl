json.result do
  json.success result[:success]
  json.message result[:message]  if result[:message]
  json.errors  result[:errors]   if result[:success] == false and result[:errors]
end
