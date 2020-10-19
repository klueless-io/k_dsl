class JsonHashValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    if !valid_json(value)
      record.errors[attribute] << 'is not valid json'
    end
  end

  private

  def valid_json(value)
    return true     if value.nil?

    return true     if value.class == Hash

    return false
  end
end
