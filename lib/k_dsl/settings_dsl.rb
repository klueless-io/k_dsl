# frozen_string_literal: true

module KDsl
  # Builds up key/value settings from the block and applies them to a key coded node on the hash 
  class SettingsDsl
    attr_reader :k_parent
    attr_reader :k_key

    alias kp k_parent

    def initialize(data, key = nil, **options, &block)
      @data = data
      @k_key = (key || 'settings').to_s

      @k_parent = options[:k_parent] if !options.nil? && options.key?(:k_parent)

      @data[@k_key] = {} # HashWithIndifferentAccess.new
      @i = 5

      # Need a way to find out the line number for errors and report it correctly
      begin
        instance_eval(&block) if block_given?
        # rubocop:disable Style/RescueStandardError
      rescue => e
        # rubocop:enable Style/RescueStandardError
        puts "Invalid code block in settings_dsl: #{@k_key}"
        puts e.message
        # L.heading "Invalid code block in settings_dsl: #{@k_key}"
        # L.exception e
        raise
      end
    end

    # NEEDS REFACTOR
    # READ THIS: https://rubystyle.guide/#no-method-missing
    # def respond_to_missing?(method_name, *args)
    #   method_name == :bark or super
    # end

    # rubocop:disable Style/MethodMissingSuper, Style/MissingRespondToMissing
    def method_missing(name, *args, &_block)
      if args.length.zero?
        @data[@k_key][name.to_s]
      else
        @data[@k_key][name.to_s] = args[0]
      end

      # puts [@k_key,name, args, block, @data]

      # read_attribute = <<-RUBY
      # def #{name}
      #   # get_value(name.to_s)
      #   @data['#{@k_key}']['#{name}']
      # end
      # RUBY

      # Have not got this working yet
      # https://www.mindmeister.com/1391592384
      #
      # As a developer, I may want to call description "value" x 2 and not see exception, so that I an redefined a property
      #
      # L.block "DUPLICATE SETTING '#{name}', you have used this setting previously in the block"
      # write_attribute = <<-RUBY
      # def #{name}=(value)
      #   @data['#{@k_key}']['#{name}'] = value
      # end
      # RUBY
      # puts 'WRITE ATTRIBUTE'
      # self.class_eval(read_attribute, __FILE__, __LINE__)

      # puts write_attribute
      # SettingsDsl.class_eval(write_attribute, __FILE__, __LINE__)

      # result
    end
    # rubocop:enable Style/MethodMissingSuper, Style/MissingRespondToMissing

    def get_value(name)
      @data[@k_key][name.to_s]
    end

    def to_h
      @data
    end

    def k_debug
      puts JSON.pretty_generate(@data[@k_name])
    end
  end
end
