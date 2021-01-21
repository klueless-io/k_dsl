# ------------------------------------------------------------
# Ruby Commandlet Features
# ------------------------------------------------------------

KDsl.document :usage do
  # settings do
  # end

  def on_action
    # write_json is_edit: true
  end

  table :example_groups do
    fields [:key, :group, :description, f(:featured, false)]

    row :basic_example            , :basic_example          , 'This example assumes you have this simple class', featured: true
    row :basic_example_renderer   , :rendering_examples     , 'Here a list of example renderers for the simple class', featured: true

    row :sample                   , :sample_classes         , 'The usage examples listed below will work with these sample classes'
    row :bci                      , :build_class_information, 'Use build_class_info to extract meta data from a ruby class'
    row :rc                       , :render_class           , 'Render a class using a pre-defined class renderer that can be referenced by key'
    row :complex_example_renderer , :render_class_examples  , 'Here a list of example renderers for the complex class'
  end

  table :examples do
    # status: :done, :current, :backlog:
    # fields [f(:type, :story), f(:status, :todo), :story, :tasks, f(:featured_position, 0)]

    fields [:group_key, :name, :description, :ruby]

    row :sample, 'Simple example', <<~TEXT, ruby: <<~RUBY
      TEXT
        module Sample
          class SimpleClass
            attr_accessor :read_write
        
            def position_and_optional(aaa, bbb = 1)
            end

            def optional_styles(aaa, bbb = 123, ccc = 'abc', ddd = true, eee = false, fff: 123, ggg: 'xyz', hhh: true, iii: false);
            end
          end
        end      
      RUBY

    row :sample, 'Complex example', <<~TEXT, ruby: <<~RUBY
      TEXT
        module Sample
          class ComplexClass
            attr_accessor :a_read_write1, :a_read_write2
            attr_reader   :b_reader, :b_another_reader
            attr_writer   :c_writer, :c_another_writer
        
            def do_something_method
            end
        
            def looks_like_an_attr_reader
              @looks_like_an_attr_reader ||= 5
            end
        
            def method_01(aaa); end
        
            def method_02(aaa, bbb = 1); end
        
            def method_03(aaa, bbb = 1, ccc = 2); end
        
            def method_04(*aaa); end
        
            def method_05(aaa, bbb = 1, *ccc); end
        
            def method_06(**aaa); end
        
            def method_07(aaa, *bbb, ccc: 'string1', **ddd); end
        
            def method_08(aaa, *bbb, **ccc, &ddd); end
        
            def method_09(aaa:); end
        
            def method_10(aaa:, bbb: 1); end
        
            def questionable?; end
        
            def destructive!; end
        
            def method_with_every_type_of_paramater(aaa, bbb = 1, *ccc, ddd:, eee: 1, **fff, &ggg); end
        
            # Check that methods are sorted
            def alpha_sort2;                                        end
            def alpha_sort1;                                        end
          end
        end      
      RUBY

    row :basic_example, '', <<~TEXT, ruby: <<~RUBY
      TEXT
        module Sample
          class SimpleClass
            attr_accessor :read_write
        
            def position_and_optional(aaa, bbb = 1)
            end
          end
        end      
      RUBY

    row :basic_example_renderer, 'Class interface', 'Render simple class using class_interface renderer with compact formatting',
      ruby: <<~RUBY
        puts api.render_class(:class_interface, instance: Sample::SimpleClass.new)
      RUBY

    row :basic_example_renderer, code_block: {
      format: :ruby,
      content: <<~RUBY
        class SimpleClass
          attr_accessor :read_write
        
          def optional_styles(aaa, bbb = 123, ccc = 'abc', ddd = true, eee = false, fff: 123, ggg: 'xyz', hhh: true, iii: false);end
          def position_and_optional(aaa, bbb = 1);                                        end
        end
      RUBY
    }

    row :basic_example_renderer, 'Documented class interface', 'Render simple class using class_interface_yard renderer to product YARD compatible documentation',
      ruby: <<~RUBY
        puts api.render_class(:class_interface_yard, instance: Sample::SimpleClass.new)
      RUBY

    row :basic_example_renderer, code_block: {
      format: :ruby,
      content: <<~RUBY
        class SimpleClass
          # Read write
          attr_accessor :read_write
        
          # Position and optional
          #
          # @param aaa [String] aaa (required)
          # @param bbb [String] bbb (optional)
          def position_and_optional(aaa, bbb = nil)
          end
        end
      RUBY
    }

    row :basic_example_renderer, 'Class debug', 'Render debug information',
      ruby: <<~RUBY
        puts api.render_class(:class_debug, instance: Sample::SimpleClass.new)
      RUBY

    row :basic_example_renderer, code_block: {
      format: :text,
      content: <<~TEXT
        ----------------------------------------------------------------------
        class name                    : SimpleClass
        module name                   : Sample
        class full name               : Sample::SimpleClass
        
        -- Attributes --------------------------------------------------------
        attr_accessor                 : read_write
        
        -- Public Methods ----------------------------------------------------
        position_and_optional::
        name                 param format         type
        ----------------------------------------------------------------------
        aaa                  aaa                  param_required
        bbb                  bbb = nil            param_optional
      TEXT
    }

    row :bci, 'Build ClassInfo', <<~TEXT, ruby: <<~RUBY
      By default information is lazy loaded only when accessed
      TEXT
        class_info = api.build_class_info(Sample::SimpleClass.new)

        puts class_info
      RUBY

    row :bci, code_block: {
      format: :shell,
      content: <<~SH
        Sample::SimpleClass
      SH
    }

    row :bci, 'Build ClassInfo - pre-loaded', <<~TEXT, ruby: <<~RUBY
      Pre-load will ensure that methods and parameters are loaded straight away.
      TEXT
        class_info = api.build_class_info(Sample::ComplexClass.new, lazy: false)

        puts class_info
      RUBY

    row :bci, code_block: {
        format: :shell,
        content: <<~SH
          Sample::ComplexClass
        SH
      }
  
    row :rc , 'Render class interface using class_info', <<~TEXT, ruby: <<~RUBY
      Render a basic class interface in compact format "One line per method".
      
      Note: Modules are not yet supported in Peeky
      TEXT
        class_info = api.build_class_info(Sample::SimpleClass.new)

        puts api.render_class(:class_interface, class_info: class_info)
      RUBY
  
    row :rc , 'Render class interface using an instance of the intended class',
      ruby: <<~RUBY
        puts api.render_class(:class_interface, instance: Sample::SimpleClass.new)
      RUBY
    
  
    row :complex_example_renderer, 'Class interface', 'Render simple class using class_interface renderer',
      ruby: <<~RUBY
        puts api.render_class(:class_interface, instance: Sample::SimpleClass.new)
      RUBY

    row :complex_example_renderer, code_block: {
      format: :ruby,
      content: <<~RUBY
        class ComplexClass
          attr_accessor :a_read_write1
          attr_accessor :a_read_write2
        
          attr_reader :b_another_reader
          attr_reader :b_reader
          attr_reader :looks_like_an_attr_reader
        
          attr_writer :c_another_writer
          attr_writer :c_writer
        
          def alpha_sort1;                                                                end
          def alpha_sort2;                                                                end
          def destructive!;                                                               end
          def do_something_method;                                                        end
          def method_01(aaa);                                                             end
          def method_02(aaa, bbb = 1);                                                    end
          def method_03(aaa, bbb = 1, ccc = 2);                                           end
          def method_04(*aaa);                                                            end
          def method_05(aaa, bbb = 1, *ccc);                                              end
          def method_06(**aaa);                                                           end
          def method_07(aaa, *bbb, ccc: 'string1', **ddd);                                end
          def method_08(aaa, *bbb, **ccc, &ddd);                                          end
          def method_09(aaa:);                                                            end
          def method_10(aaa:, bbb: 1);                                                    end
          def method_with_every_type_of_paramater(aaa, bbb = 1, *ccc, ddd:, eee: 1, **fff, &ggg);end
          def questionable?;                                                              end
        end
      RUBY
    }

    row :complex_example_renderer, 'Class interface - YARD','Render complex class using class_interface_yard renderer',
      ruby: <<~RUBY
        puts api.render_class(:class_interface_yard, instance: Sample::ComplexClass.new)
      RUBY

    row :complex_example_renderer, code_block: {
      format: :ruby,
      content: <<~RUBY
        class ComplexClass
          # A read write1
          attr_accessor :a_read_write1
        
          # A read write2
          attr_accessor :a_read_write2
        
          # B another reader
          attr_reader :b_another_reader
        
          # B reader
          attr_reader :b_reader
        
          # Looks like an attr reader
          attr_reader :looks_like_an_attr_reader
        
          # C another writer
          attr_writer :c_another_writer
        
          # C writer
          attr_writer :c_writer
        
          # Alpha sort1
          def alpha_sort1
          end
        
          # Alpha sort2
          def alpha_sort2
          end
        
          # Destructive!
          def destructive!
          end
        
          # Do something method
          def do_something_method
          end
        
          # Method 01
          #
          # @param aaa [String] aaa (required)
          def method_01(aaa)
          end
        
          # Method 02
          #
          # @param aaa [String] aaa (required)
          # @param bbb [String] bbb (optional)
          def method_02(aaa, bbb = nil)
          end
        
          # Method 03
          #
          # @param aaa [String] aaa (required)
          # @param bbb [String] bbb (optional)
          # @param ccc [String] ccc (optional)
          def method_03(aaa, bbb = nil, ccc = nil)
          end
        
          # Method 04
          #
          # @param aaa [Array<Object>] *aaa - list of aaa
          def method_04(*aaa)
          end
        
          # Method 05
          #
          # @param aaa [String] aaa (required)
          # @param bbb [String] bbb (optional)
          # @param ccc [Array<Object>] *ccc - list of ccc
          def method_05(aaa, bbb = nil, *ccc)
          end
        
          # Method 06
          #
          # @param aaa [<key: value>...] **aaa - list of key/values
          def method_06(**aaa)
          end
        
          # Method 07
          #
          # @param aaa [String] aaa (required)
          # @param bbb [Array<Object>] *bbb - list of bbb
          # @param ccc [<key: value>...] **ccc - list of key/values
          def method_07(aaa, *bbb, **ccc)
          end
        
          # Method 08
          #
          # @param aaa [String] aaa (required)
          # @param bbb [Array<Object>] *bbb - list of bbb
          # @param ccc [<key: value>...] **ccc - list of key/values
          # @param ddd [Block] &ddd
          def method_08(aaa, *bbb, **ccc, &ddd)
          end
        
          # Method 09
          #
          # @param aaa [String] aaa: <value for aaa> (required)
          def method_09(aaa:)
          end
        
          # Method 10
          #
          # @param aaa [String] aaa: <value for aaa> (required)
          # @param bbb [String] bbb: <value for bbb> (optional)
          def method_10(aaa:, bbb: nil)
          end
        
          # Method with every type of paramater
          #
          # @param aaa [String] aaa (required)
          # @param bbb [String] bbb (optional)
          # @param ccc [Array<Object>] *ccc - list of ccc
          # @param ddd [String] ddd: <value for ddd> (required)
          # @param eee [String] eee: <value for eee> (optional)
          # @param fff [<key: value>...] **fff - list of key/values
          # @param ggg [Block] &ggg
          def method_with_every_type_of_paramater(aaa, bbb = nil, *ccc, ddd:, eee: nil, **fff, &ggg)
          end
        
          # Questionable?
          #
          # @return [Boolean] true when questionable?
          def questionable?
          end
        end
      RUBY
    }

    row :complex_example_renderer, 'Debug class info', 'Render debug information on complex class',
      ruby: <<~RUBY
        puts api.render_class(:class_debug, instance: Sample::ComplexClass.new)
      RUBY

    row :complex_example_renderer, code_block: {
      format: :text,
      content: <<~TEXT
        ----------------------------------------------------------------------------------------------------
        class name                    : ComplexClass
        module name                   : Sample
        class full name               : Sample::ComplexClass
        
        -- Attributes --------------------------------------------------------------------------------------
        attr_accessor                 : a_read_write1
        attr_accessor                 : a_read_write2
        attr_reader                   : b_another_reader
        attr_reader                   : b_reader
        attr_reader                   : looks_like_an_attr_reader
        attr_writer                   : c_another_writer
        attr_writer                   : c_writer
        
        -- Public Methods ----------------------------------------------------------------------------------
        alpha_sort1::
        name                     param format             type                     default
        ----------------------------------------------------------------------------------------------------
        
        alpha_sort2::
        name                     param format             type                     default
        ----------------------------------------------------------------------------------------------------
        
        destructive!::
        name                     param format             type                     default
        ----------------------------------------------------------------------------------------------------
        
        do_something_method::
        name                     param format             type                     default
        ----------------------------------------------------------------------------------------------------
        
        method_01::
        name                     param format             type                     default
        ----------------------------------------------------------------------------------------------------
        aaa                      aaa                      param_required
        
        method_02::
        name                     param format             type                     default
        ----------------------------------------------------------------------------------------------------
        aaa                      aaa                      param_required
        bbb                      bbb = 1                  param_optional           1
        
        method_03::
        name                     param format             type                     default
        ----------------------------------------------------------------------------------------------------
        aaa                      aaa                      param_required
        bbb                      bbb = 1                  param_optional           1
        ccc                      ccc = 2                  param_optional           2
        
        method_04::
        name                     param format             type                     default
        ----------------------------------------------------------------------------------------------------
        aaa                      *aaa                     splat
        
        method_05::
        name                     param format             type                     default
        ----------------------------------------------------------------------------------------------------
        aaa                      aaa                      param_required
        bbb                      bbb = 1                  param_optional           1
        ccc                      *ccc                     splat
        
        method_06::
        name                     param format             type                     default
        ----------------------------------------------------------------------------------------------------
        aaa                      **aaa                    double_splat
        
        method_07::
        name                     param format             type                     default
        ----------------------------------------------------------------------------------------------------
        aaa                      aaa                      param_required
        bbb                      *bbb                     splat
        ccc                      ccc: 'string1'           key_optional             string1
        ddd                      **ddd                    double_splat
        
        method_08::
        name                     param format             type                     default
        ----------------------------------------------------------------------------------------------------
        aaa                      aaa                      param_required
        bbb                      *bbb                     splat
        ccc                      **ccc                    double_splat
        ddd                      &ddd                     block
        
        method_09::
        name                     param format             type                     default
        ----------------------------------------------------------------------------------------------------
        aaa                      aaa:                     key_required
        
        method_10::
        name                     param format             type                     default
        ----------------------------------------------------------------------------------------------------
        aaa                      aaa:                     key_required
        bbb                      bbb: 1                   key_optional             1
        
        method_with_every_type_of_paramater::
        name                     param format             type                     default
        ----------------------------------------------------------------------------------------------------
        aaa                      aaa                      param_required
        bbb                      bbb = 1                  param_optional           1
        ccc                      *ccc                     splat
        ddd                      ddd:                     key_required
        eee                      eee: 1                   key_optional             1
        fff                      **fff                    double_splat
        ggg                      &ggg                     block
        
        questionable?::
        name                     param format             type                     default
        ----------------------------------------------------------------------------------------------------
      TEXT
    }
  end
end
