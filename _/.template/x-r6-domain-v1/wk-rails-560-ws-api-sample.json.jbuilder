# Sample list of endpoints for {{camelU settings.Model}}
json.partial! 'api/v1/result', result: result

json.partial! 'api/v1/sample', locals: { endpoints: endpoints } if result[:success]
