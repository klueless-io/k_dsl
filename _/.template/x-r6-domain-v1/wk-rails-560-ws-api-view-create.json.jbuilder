json.partial! 'api/v1/result', result: result

json.row row, partial: 'row', as: :row if result[:success]
