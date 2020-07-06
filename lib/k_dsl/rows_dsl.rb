# frozen_string_literal: true

module KDsl
  # Build rows (aka DataTable) with field definitions and rows of data
  class RowsDsl
    attr_reader :name

    def initialize(data, name = nil, &block)
      @data = data
      @name = (name || 'rows').to_s

      @data[@name] = { 'fields' => [], 'rows' => [] }

      instance_eval(&block) if block_given?
    end

    def fields(field_definitions)
      fields = @data[@name]['fields']

      field_definitions.each do |fd|
        fields << if fd.is_a?(String) || fd.is_a?(Symbol)
                    field(fd, nil, :string)
                  else
                    fd
                  end
      end
    end

    def row(*args, **options)
      fields = @data[@name]['fields']

      raise "To many values for row, argument #{i}" if args.length > fields.length

      # Set default key / values
      row = fields.reduce({}) { |hash, f| hash[f['name']] = f['default']; hash }

      # Override with positional args
      args.each_with_index { |arg, i| row[fields[i]['name']] = convert_symbol(arg) }

      # Override with named options
      safe_options = HashWithIndifferentAccess.new(options)
      safe_options.keys.each { |key| row[key] = safe_options[key] }

      @data[@name]['rows'] << row
    end

    def get_fields
      @data[@name]['fields']
    end

    def get_rows
      @data[@name]['rows']
    end

    def find_row(key, value)
      @data[@name]['rows'].find { |r| r[key] == value }
    end

    # Field definition
    #
    # @param [String|Symbol] name Name of the field
    # @param arg_default Default value if not specified, nil if not set
    # @param arg_type Type of data, string if not set
    # @param default: Default value (using named params), as above
    # @param type: Type of data (using named params), as above
    # @return [Hash] Field definition
    def field(name, *args, default: nil, type: nil)

      # default value can be found at position 0 or default: tag (see unit test edge cases)
      default_value = if args.length.positive?
                        args[0].nil? ? default : args[0]
                      else
                        default
                      end

      # type can be found at position 1 or type: tag
      type_value = args.length > 1 ? args[1] : type

      {
        name: clean_symbol(name),
        default: clean_symbol(default_value),
        type: clean_symbol(type_value)
      }
    end
    alias f field

    def clean_symbol(value)
      return value if value.nil?

      value.is_a?(Symbol) ? value.to_s : value
    end

    def method_missing(key, *_args, &_block)
      puts "method missing #{key}"
      # @data[@name][key] = args[0]
    end

    # ------------------------------------------------------------
    # The following methods really need to be in their own specialized
    # classes that extend RowDsl and exist specificall for each
    # DocumentDsl that exists
    # ------------------------------------------------------------
    
    # There are not tests, this is just concept code for now

    def one2one(entity, **args)
      raise "one2one can only be used with entity types: #{entity.model}" if entity.artifact_type != 'entity'

      row entity.model, entity.models , "#{entity.model}_id", 'OneToOne', nil, entity.main_key, entity.td_key1, entity.td_key2, entity.td_key3, args
    end

    def one2many(entity)
      raise "one2many can only be used with entity types: #{entity.model}" if entity.artifact_type != 'entity'

      row entity.model, entity.models , "#{entity.model}_id", 'OneToMany', nil, entity.main_key, entity.td_key1, entity.td_key2, entity.td_key3, args
    end

  end
end
