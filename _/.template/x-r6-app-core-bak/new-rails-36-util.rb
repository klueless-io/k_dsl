module Util
  def self.to_bool(data, default = false)
    if data.nil?
      return default
    end

    if !!data == data
      return data
    end

    if data.is_a? String
      return true if data =~ (/^(true|t|yes|y|1)$/i)

      return false if data =~ (/^(false|f|no|n|0)$/i)
    end

    return default

  end

  def self.is_bool(data)
    !!data == data
  end

  def self.parse_as_hash(data, symbolize = false)

    result = {}

    if !data.nil?

      if data.is_a?(String)
        if symbolize
          # if you want to convert into ruby symbols then set symbolize to true
          # see: https://stackoverflow.com/questions/1732001/what-is-the-best-way-to-convert-a-json-formatted-key-value-pair-to-ruby-hash-wit
          result = Marshal.load( Marshal.dump(data) )
        else
          result = JSON.parse(data)
        end

      elsif data.is_a?(Hash)
        result = data

      else
        raise
      end
    end

    result

  end

  def self.parse_int(value, defValue = -1)

    if (string_equivalent_of_empty_number(value))
      return defValue;
    end

    begin
      return Integer(value)
    rescue ArgumentError
      return defValue;
    end
  end

end