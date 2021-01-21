# frozen_string_literal: true

require 'spec_helper'

RSpec.describe KDsl::Model::Settings do
  let(:data) { {} }

  describe '.key' do
    context 'when no key' do
      subject { described_class.new(data).key }

      it { expect(subject).to eq('settings') }
    end

    context 'when key supplied' do
      subject { described_class.new(data, 'my-key').key }

      it { expect(subject).to eq('my-key') }
    end
  end

  describe '.parent' do
    subject { described_class.new(data, parent: parent).parent }

    context 'when not attached to parent' do
      let(:parent) { nil }

      it 'parent is nil' do
        expect(subject).to be_nil
      end
    end

    context 'when parent supplied' do
      subject { described_class.new(data, parent: parent).parent }

      context 'when attached to a parent object' do
        let(:parent) { KDsl::Model::Document.new(:x) }

        it { expect(subject).not_to be_nil }
        it { expect(subject.key).to eq(:x) }
        it { expect(subject.type).to eq(:entity) }
      end
      
      context 'when accessing dynamic method on parent' do
        subject { document }
        let(:document) do
          KDsl::Model::Document.new do
            def its
              'crazy'
            end

            settings do
              sanity its
            end
          end
        end

        before { subject.execute_block }            

        it { is_expected.to have_attributes(settings: have_attributes(its: 'crazy'))}
      end
    end
  end

  context 'deprecations' do
    context 'when k_parent supplied' do
      subject { described_class.new(data, k_parent: 'some object') }

      it { expect { subject }.to raise_error 'k_parent has been deprecated'}
    end
  end

  context 'with setting groups' do
    it 'and key is nil' do
      described_class.new(data)

      expect(data).to eq({ KDsl.config.default_settings_key.to_s => {} })
    end

    it 'and key is :key_values' do
      described_class.new(data, :key_values)

      expect(data).to eq({ 'key_values' => {} })
    end

    it 'and key is "key_values"' do
      described_class.new(data, 'key_values')

      expect(data).to eq({ 'key_values' => {} })
    end

    it 'and key is :key_values' do
      described_class.new(data, :key_values)

      expect(data).to eq({ 'key_values' => {} })
    end
  end

  context 'simple setting' do
    subject do
      described_class.new(data) do
        the 'quick'
      end
    end
    # after do
    #   subject.instance_eval do
    #     undef :unknown_attribute if respond_to? :unknown_attribute
    #     undef :unknown_attribute= if respond_to? :unknown_attribute=
    #   end

    #   # described_class.class_eval do
    #   #   remove_method :unknown_attribute if respond_to? :unknown_attribute
    #   #   remove_method :unknown_attribute= if respond_to? :unknown_attribute=
    #   # end
    # end
    describe 'respond_to?' do
      context 'when attribute is used' do
        it 'will respond to getter' do
          expect(subject).to respond_to(:the)
        end
        it 'will respond to setter' do
          expect(subject).to respond_to(:the=)
        end
      end

      context 'when attribute is unknown1' do
        it 'will not respond to getter' do
          expect(subject).not_to respond_to(:unknown1_attribute)
        end
        it 'will not respond to setter' do
          expect(subject).not_to respond_to(:unknown1_attribute=)
        end
      end
    end

    describe 'get attribute value' do
      context 'when attribute already set' do
        it 'will have valid value' do
          expect(subject.the).to eq('quick')
        end
      end

      context 'when attribute is unknown2' do
        it 'will return nil' do
          expect(subject.unknown2_attribute).to be_nil
        end
      end
    end

    describe 'set attribute value' do
      describe 'via setter' do
        context 'when attribute already set' do
          it 'will update the attribute' do
            subject.the = 'slow'
            expect(subject.the).to eq('slow')
          end
        end

        context 'when attribute is unknown' do
          it 'will set the new attribute' do
            subject.unknown3_attribute = 'no so unknown now'
            expect(subject.unknown3_attribute).to eq('no so unknown now')
          end
        end
      end
      describe 'via method' do
        context 'when attribute already set' do
          it 'will update the attribute' do
            subject.the('slow')
            expect(subject.the).to eq('slow')
          end
        end

        context 'when attribute is unknown' do
          it 'will set the new attribute' do
            # subject.unknown_attribute('no so unknown now')
            # expect(subject.unknown_attribute).to eq('no so unknown now')
          end
        end
      end
    end
  end

  context 'setting key/values' do
    it 'no &block' do
      described_class.new(data)

      expect(data).to eq({ 'settings' => {} })
    end

    it 'default limited and get value' do
      dsl = described_class.new(data, :settings) do
        rails_port        3000
        model             'User'
        active            true
      end

      expect(data).to eq({ 'settings' => { 'rails_port' => 3000, 'model' => 'User', 'active' => true } })

      expect(dsl.get_value(:rails_port)).to eq(3000)
      expect(dsl.get_value(:model)).to eq('User')
      expect(dsl.get_value(:active)).to eq(true)
    end

    it 'default full' do
      described_class.new(data, :key_values) do
        rails_port           3000
        model_type           'AdminUser'
        model                'AdminUser'
        models               'AdminUsers'
        main_key             'email'
        note                 'password is an alias to encrypted_password'

        # Can this be in a test data use case object
        td_key1              'super'
        td_key2              'management'
        td_key3              'engineering'
        td_query             %w[01 02 03 04 10 11 12 13]
      end

      expect(data).to eq('key_values' =>
        {
          'rails_port' => 3000,
          'model_type' => 'AdminUser',
          'model' => 'AdminUser',
          'models' => 'AdminUsers',
          'main_key' => 'email',
          'note' => 'password is an alias to encrypted_password',
          'td_key1' => 'super',
          'td_key2' => 'management',
          'td_key3' => 'engineering',
          'td_query' => %w[01 02 03 04 10 11 12 13]
        })
    end
  end

  context 'setting get values by key' do
    subject do
      described_class.new(data, :settings) do
        rails_port        3000
        model             'User'
        active            true
      end
    end

    it 'get value by symbol' do
      expect(subject.get_value(:rails_port)).to eq(3000)
      expect(subject.get_value(:model)).to eq('User')
      expect(subject.get_value(:active)).to eq(true)
    end

    it 'get value by string' do
      expect(subject.get_value('rails_port')).to eq(3000)
      expect(subject.get_value('model')).to eq('User')
      expect(subject.get_value('active')).to eq(true)
    end

    it 'get value by attr_reader' do
      expect(subject.rails_port).to eq(3000)
      expect(subject.model).to eq('User')
      expect(subject.active).to eq(true)
    end
  end

  describe 'error handling' do
    context 'multiple setting values from &block' do
      subject { described_class.new(data) { multiple_x(1, 2) } }

      it { expect { subject }.to raise_error(KDsl::Error) }
    end

    context 'multiple setting values from attribute' do
      subject { described_class.new(data) }

      it do
        subject.multiple_y(1, 2)
      end
      it { expect { subject.multiple_y(1, 2) }.to raise_error(KDsl::Error) }
    end
  end

  class MySettings
    attr_accessor :data
  
    def initialize(&block)
      @data = {}
      instance_eval(&block) if block_given?
    end

    def add_getter_or_param_method(name)
      self.class.class_eval do
        name = name.to_s.gsub(/\=$/, '')
        define_method(name) do |*args|
          raise KDsl::Error, 'Multiple setting values is not supported' if args.length > 1

          if args.length.zero?
            get_value(name)
          else
            send("#{name}=", args[0])
          end
        end
      end
    end

    def add_setter_method(name)
      self.class.class_eval do
        name = name.to_s.gsub(/\=$/, '')
        define_method("#{name}=") do |value|
          @data[name.to_s] = value
        end
      end
    end

    def get_value(name)
      @data[name.to_s]
    end

    def respond_to_missing?(name, *_args, &_block)
      n = name.to_s
      n = n[0..-2] if n.end_with?('=')
      @data.key?(n) || super
    end

    def method_missing(name, *args, &_block)
      puts 'dynamic method started'
      raise KDsl::Error, 'Multiple setting values is not supported' if args.length > 1

      puts 'dynamic method all good'

      # add_getter_or_param_method(name)
      # add_setter_method(name)
              
      # send(name, args[0]) if args.length === 1 #name.end_with?('=')
      
      # super unless self.class.method_defined?(name)
    end
  end

  # describe 'dynamic method accepts one parameter only' do
  #   let(:instance) { MySettings.new }
  #   subject { instance }

  #   it { is_expected.to have_attributes( data: {}) }

  #   context 'single setting value from attribute' do
  #     subject { instance.single(1) }

  #     fit do
  #       instance.xyz(1, 2)
  #     end
  #     # fit { is_expected.to have_attributes( data: { single: 1 }) }
  #   end

  #   context 'multiple setting values from &block' do
  #     subject { described_class.new(data) { multiple(1, 2) } }

  #     it { expect { subject }.to raise_error(KDsl::Error) }
  #   end

  #   context 'multiple setting values from attribute' do
  #     subject { described_class.new(data) }

  #     it { expect { subject.multiple(1, 2) }.to raise_error(KDsl::Error) }
  #   end

  # end

  # class A
  #   attr_accessor :a
  #   attr_reader   :b
  #   attr_writer   :c

  #   def d;                                  end
  #   def e(a);                               end
  #   def f(a, b = 1);                        end
  #   def g(a, b = 1, c = 2);                 end
  #   def h(*a);                              end
  #   def i(a, b, *c);                        end
  #   def j(**a);                             end
  #   def k(a, *b, **c);                      end
  #   def l(a, *b, **c, &d);                  end
  #   def m(a:);                              end
  #   def n(a:, b: 1);                        end
  #   def p?;                                 end
  #   def z(a, b = 1, *c, d:, e: 1, **f, &g); end
  # end

  # class B
  #   def d;
  #     puts '[ d() ] ------------------------------------------------------------'
  #   end
  #   def e(a);
  #     puts '[ e() ] ------------------------------------------------------------'
  #     puts a
  #   end
  #   def f(a, b = 1);
  #     puts '[ f() ] ------------------------------------------------------------'
  #     puts a
  #     puts b
  #   end
  #   def g(a, b = 1, c = 2);
  #     puts '[ g() ] ------------------------------------------------------------'
  #     puts a
  #     puts b
  #     puts c
  #   end
  #   def h(*a);
  #     puts '[ h() ] ------------------------------------------------------------'
  #     puts a
  #   end
  #   def i(a, b, *c);
  #     puts '[ i() ] ------------------------------------------------------------'
  #     puts a
  #     puts b
  #     puts c
  #   end
  #   def j(**a);
  #     puts '[ j() ] ------------------------------------------------------------'
  #     puts a
  #   end
  #   def k(a, *b, **c);
  #     puts '[ k() ] ------------------------------------------------------------'
  #     puts a
  #   end
  #   def l(a, *b, **c, &d);
  #     puts '[ l() ] ------------------------------------------------------------'
  #     puts a
  #     puts b
  #     puts c
  #     puts d
  #   end
  #   def m(a:);
  #     puts '[ m() ] ------------------------------------------------------------'
  #     puts a
  #   end
  #   def n(a:, b: 1);
  #     puts '[ n() ] ------------------------------------------------------------'
  #     puts a
  #     puts b
  #   end
  #   def p?;
  #     puts '[ p? ] ------------------------------------------------------------'
  #   end
  #   def z(a, b = 1, *c, d:, e: 1, **f);
  #     puts '[ z() ] ------------------------------------------------------------'
  #     puts a
  #     puts b
  #     puts c
  #     puts d
  #     puts e
  #     puts f
  #   end
  # end

  # class MethodSignatures
  #   attr_reader :method_definitions

  #   def initialize(instance, instance_name: nil )
  #     @instance = instance
  #     @instance_name = instance_name ||= instance.class.to_s.parameterize.underscore
  #     instance_methods = instance.class.instance_methods(false).sort
  #     @method_definitions = build_method_definitions(instance, instance_methods)
  #   end

  #   def build_method_definitions(instance, method_names)
  #     method_names.map do |method_name|
  #       meth = instance.method(method_name)

  #       instance_method = OpenStruct.new(
  #         klass: meth.owner,
  #         receiver: meth.receiver,
  #         name: method_name,
  #         arity: meth.arity,
  #         super: meth.super_method,
  #         original_parameters: meth.parameters,
  #         parameters: parameter_info(method_name, meth.parameters),
  #         location: meth.source_location.join(':')
  #       )
  #       instance_method.formatted_parameters = instance_method.parameters.map { |p| p[:format] }.join(', ')
  #       instance_method.minimal_call_parameters = instance_method.parameters.map { |p| p[:minimal_call] }.reject(&:blank?).join(', ')
  #       instance_method.signature = build_signature(instance_method.name, instance_method.formatted_parameters)
  #       instance_method.minimum_call_signature = build_minimal_call_signature(instance_method.name, instance_method.minimal_call_parameters)
  #       instance_method
  #     end
  #   end

  #   def parameter_info(name, params)
  #     parameter_info = params.map do |p|
  #       name = p.length > 1 ? p[1] : ''

  #       case p[0]
  #       when :req
  #         { name: name, type: :param_required, format: "#{name}"      , minimal_call: "'#{name}'" }
  #       when :opt
  #         { name: name, type: :param_optional, format: "#{name} = nil", minimal_call: "" }
  #       when :rest
  #         { name: name, type: :splat         , format: "*#{name}"     , minimal_call: "" }
  #       when :keyreq
  #         { name: name, type: :key_required  , format: "#{name}:"     , minimal_call: "#{name}: '#{name}'" }
  #       when :key
  #         { name: name, type: :key_optional  , format: "#{name}: nil" , minimal_call: "" }
  #       when :keyrest
  #         { name: name, type: :double_splat  , format: "**#{name}"    , minimal_call: "" }
  #       when :block
  #         { name: name, type: :block         , format: "&#{name}"     , minimal_call: "" }
  #       else
  #         raise 'unknown type'
  #       end
  #     end
  #   end

  #   # Build simple method signature that matches the parameters
  #   def build_signature(name, formatted_parameters)
  #     params = formatted_parameters.length == 0 ? '' : "(#{formatted_parameters})"
  #     lhs = "def #{name}#{params};"
  #     rhs = 'end'
  #     "#{lhs.ljust(46)}#{rhs}"
  #   end

  #   # Build a minimal method call, that means the method will run with the simplest 
  #   # number of parameters possible
  #   def build_minimal_call_signature(name, minimal_call_parameters)
  #     params = minimal_call_parameters.length == 0 ? '' : "(#{minimal_call_parameters})"
  #     "#{@instance_name}.#{name}#{params}"
  #   end
    
  #   # Helpers for printing
  #   def print(*formats)
  #     formats ||= %i[signature]

  #     formats.each do |format|
  #       case format
  #       when :signature
  #         puts '-' * 70
  #         puts "Generate method signatures for class '#{@instance.class}'"
  #         puts '-' * 70
  #         self.method_definitions.each { |md| puts md.signature }
  #         puts '-' * 70

  #       when :minimal_call
  #         puts '-' * 70
  #         puts "Generate minimalistic method calls for class '#{@instance.class}'"
  #         puts '-' * 70
  #         puts "#{@instance_name} = #{@instance.class}.new"
  #         puts ''
  #         self.method_definitions.each { |md| puts md.minimum_call_signature }
  #         puts '-' * 70
  #       end
  #     end
  #   end

  #   # Helpers for printing using table_print GEM
  #   def print1
  #     tp self.method_definitions,
  #       :klass,
  #       :name,
  #       :arity,
  #       'parameters.name',
  #       'parameters.type',
  #       'parameters.format'
  #   end

  #   # Helpers for printing using table_print GEM
  #   def print2
  #     tp self.method_definitions,
  #       :klass,
  #       :name,
  #       :arity,
  #       { formatted_parameters: { width: 140 } },
  #       { signature: { width: 140 } }
  #   end
  # end

  # it 'print method signatures for class: A' do
  #   class_definition = MethodSignatures.new(A.new)
  #   class_definition.print(:signature)
  # end

  # it 'print minimal method calls for class: A' do
  #   class_definition = MethodSignatures.new(A.new, instance_name: 'my_a')
  #   class_definition.print(:minimal_call)
  # end
    
  # fit '' do
  #   # TracePoint.trace(:call, :return, :c_call, :c_return) do |tp|
  #   #   next unless tp.self.is_a?(A)
  #   #   event = tp.event.to_s.sub(/(.+(call|return))/, '\2').rjust(6, " ")
  #   #   message = "#{event} of #{tp.defined_class}##{tp.callee_id} on #{tp.self.inspect}"
  #   #   # if you call `return` on any non-return events, it'll raise error
  #   #   message += " => #{tp.return_value.inspect}" if tp.event == :return || tp.event == :c_return
  #   #   puts(message)
  #   # end
    
  #   my_a = A.new

  #   TracePoint.trace(:call, :c_call) do |tp|
  #     next unless tp.self.is_a?(A)
  #     if (tp.method_id == :attr_accessor)
  #       tp.self.extend(MethodTracer)
  
  #       methods = tp.self::Methods ||= []
  #       MethodTracer.send(:define_method, :method_added) {|m| methods << m }
  #     end
  #     puts 'david'
  #     tp.parameters.each do |type, name|
  #       value = tp.binding.local_variable_get(name)
  #       puts format('%8s: %s = %s', type, name, value.inspect)
  #     end
  #   end

  #   # my_a.a
  #   my_a.a= 'xxxx'
  #   # my_a.b
  #   # my_a.c=('')
  #   # my_a.d
  #   # my_a.e('a')
  #   # my_a.f('a')
  #   # my_a.g('a')
  #   # my_a.h
  #   # my_a.i('a', 'b')
  #   # my_a.j
  #   # my_a.k('a')
  #   # my_a.l('a')
  #   # my_a.m(a: 'a')
  #   # my_a.n(a: 'a')
  #   # my_a.p?
  #   # my_a.z('a', d: 'd')
  # end

  it 'print signatures B' do
    # class_definition = MethodSignatures.new(B.new)
    # class_definition.print(:signature, :minimal_call)
    # class_definition.print(:minimal_call)

    # def d;                                  end
    # def e(a);                               end
    # def f(a, b = 1);                        end
    # def g(a, b = 1, c = 2);                 end
    # def h(*a);                              end
    # def i(a, b, *c);                        end
    # def j(**a);                             end
    # def k(a, *b, **c);                      end
    # def l(a, *b, **c, &d);                  end
    # def m(a:);                              end
    # def n(a:, b: 1);                        end
    # def p?;                                 end
    # def z(a, b = 1, *c, d: 1, **e);         end

    # b = B.new
    # b.d
    # b.e('a')
    # b.f('a')
    # b.g('a')
    # b.h
    # b.i('a', 'b')
    # b.j
    # b.k('a')
    # b.l('a')
    # b.m(a: 'a')
    # b.n(a: 'a')
    # b.p?
    # b.z('a', d: 'd')
  end

end
