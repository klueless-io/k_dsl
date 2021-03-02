# require 'active_support/core_ext/string'

KDsl.blueprint :_generate_helpers do

  settings do
    # output_path         '/Users/davidcruwys/dev/kgems/handlebars-helpers/_/app/helpers'
  end

  table :new_groups do
    fields %i[key name description examples]

    # row :string      , :string_formatting      , 'String formatting and manipulation methods'    , ['https://github.com/magynhard/lucky_case', 'https://github.com/rails/rails/tree/v6.1.1/activesupport', 'https://github.com/helpers/handlebars-helpers/blob/master/lib/string.js', 'https://github.com/helpers/handlebars-helpers/blob/master/test/string.js']
    # row :array       , :array                  , 'Array handling routines'                          , ['https://github.com/helpers/handlebars-helpers/blob/master/lib/array.js', 'https://github.com/helpers/handlebars-helpers/blob/master/test/array.js']
    # row :code        , :code                   , 'Code handling routines'                           , ['https://github.com/helpers/handlebars-helpers/blob/master/lib/code.js', 'https://github.com/helpers/handlebars-helpers/blob/master/test/code.js']
    # row :collection  , :collection             , 'Collection handling routines'                     , ['https://github.com/helpers/handlebars-helpers/blob/master/lib/collection.js', 'https://github.com/helpers/handlebars-helpers/blob/master/test/collection.js']
    # row :comparison  , :comparison             , 'Comparison helpers, eg. or, and, equal, not equal, less than, greater than etc.'                     , ['https://github.com/helpers/handlebars-helpers/blob/master/lib/comparison.js', 'https://github.com/helpers/handlebars-helpers/blob/master/test/comparison.js']
    # row :date        , :date                   , 'Date handling routines'                           , ['https://github.com/helpers/handlebars-helpers/blob/master/lib/date.js', 'https://github.com/helpers/handlebars-helpers/blob/master/test/date.js']
    # row :fs          , :fs                     , 'Fs handling routines'                             , ['https://github.com/helpers/handlebars-helpers/blob/master/lib/fs.js', 'https://github.com/helpers/handlebars-helpers/blob/master/test/fs.js']
    # row :html        , :html                   , 'Html handling routines'                           , ['https://github.com/helpers/handlebars-helpers/blob/master/lib/html.js', 'https://github.com/helpers/handlebars-helpers/blob/master/test/html.js']
    # row :i18n        , :i18n                   , 'I18n handling routines'                           , ['https://github.com/helpers/handlebars-helpers/blob/master/lib/i18n.js', 'https://github.com/helpers/handlebars-helpers/blob/master/test/i18n.js']
    # row :inflection  , :inflection             , 'Inflection handling routines'                     , ['https://github.com/helpers/handlebars-helpers/blob/master/lib/inflection.js', 'https://github.com/helpers/handlebars-helpers/blob/master/test/inflection.js']
    # row :logging     , :logging                , 'Logging handling routines'                        , ['https://github.com/helpers/handlebars-helpers/blob/master/lib/logging.js', 'https://github.com/helpers/handlebars-helpers/blob/master/test/logging.js']
    # row :markdown    , :markdown               , 'Markdown handling routines'                       , ['https://github.com/helpers/handlebars-helpers/blob/master/lib/markdown.js', 'https://github.com/helpers/handlebars-helpers/blob/master/test/markdown.js']
    # row :match       , :match                  , 'Match handling routines'                          , ['https://github.com/helpers/handlebars-helpers/blob/master/lib/match.js', 'https://github.com/helpers/handlebars-helpers/blob/master/test/match.js']
    # row :math        , :math                   , 'Math handling routines'                           , ['https://github.com/helpers/handlebars-helpers/blob/master/lib/math.js', 'https://github.com/helpers/handlebars-helpers/blob/master/test/math.js']
    # row :misc        , :misc                   , 'Miscellaneous handling routines'                  , ['https://github.com/helpers/handlebars-helpers/blob/master/lib/misc.js', 'https://github.com/helpers/handlebars-helpers/blob/master/test/misc.js']
    # row :number      , :number                 , 'Number handling routines'                         , ['https://github.com/helpers/handlebars-helpers/blob/master/lib/number.js', 'https://github.com/helpers/handlebars-helpers/blob/master/test/number.js', 'https://github.com/rails/rails/blob/v6.1.1/activesupport/lib/active_support/number_helper.rb']
    # row :object      , :object                 , 'Object handling routines'                         , ['https://github.com/helpers/handlebars-helpers/blob/master/lib/object.js', 'https://github.com/helpers/handlebars-helpers/blob/master/test/object.js']
    # row :path        , :path                   , 'Path handling routines'                           , ['https://github.com/helpers/handlebars-helpers/blob/master/lib/path.js', 'https://github.com/helpers/handlebars-helpers/blob/master/test/path.js']
    # row :regex       , :regex                  , 'Regex handling routines'                          , ['https://github.com/helpers/handlebars-helpers/blob/master/lib/regex.js', 'https://github.com/helpers/handlebars-helpers/blob/master/test/regex.js']
    # row :url         , :url                    , 'Url handling routines'                            , ['https://github.com/helpers/handlebars-helpers/blob/master/lib/url.js', 'https://github.com/helpers/handlebars-helpers/blob/master/test/url.js']
    # row :json        , :json                   , 'Json handling routines'                           , ['https://github.com/rails/rails/blob/v6.1.1/activesupport/lib/active_support/json.rb']
  end

  table :helper_groups do
    fields %i[key active name base_require base_namespace description examples]
  
    row :comparison, true,
        :comparison,
        'handlebars/helpers/comparison',
        'Handlebars::Helpers::Comparison',
        'Comparison helpers, eg. or, and, equal, not equal, less than, greater than etc.',
        examples: ['https://github.com/helpers/handlebars-helpers/blob/master/lib/comparison.js', 'https://github.com/helpers/handlebars-helpers/blob/master/test/comparison.js']

    row :inflection, true,
        :inflection,
        'handlebars/helpers/inflection',
        'Handlebars::Helpers::Inflection',
        'Inflection handling routines, eg. pluralize, singular, ordinalize',
        examples: ['https://github.com/helpers/handlebars-helpers/blob/master/lib/inflection.js', 'https://github.com/helpers/handlebars-helpers/blob/master/test/inflection.js']

    row :misc, true,
        :misc,
        'handlebars/helpers/misc',
        'Handlebars::Helpers::Misc',
        'Miscellaneous handling routines',
        examples: ['https://github.com/helpers/handlebars-helpers/blob/master/lib/misc.js', 'https://github.com/helpers/handlebars-helpers/blob/master/test/misc.js']
          
    row :ruby, true,
        :code_ruby,
        'handlebars/helpers/code_ruby',
        'Handlebars::Helpers::CodeRuby',
        'Ruby code handling routines',
        examples: ['https://github.com/helpers/handlebars-helpers/blob/master/lib/code.js', 'https://github.com/helpers/handlebars-helpers/blob/master/test/code.js']

    row :string, true,
        :string_formatting,
        'handlebars/helpers/string_formatting',
        'Handlebars::Helpers::StringFormatting',
        'String formatting and manipulation methods'

    end

  # Add format 
  table :helpers do
    fields %i[group names description test_in test_out test_case template is_string_formatter]

    # ----------------------------------------------------------------------
    # :inflections
    # ----------------------------------------------------------------------

    row :inflection, %i[ordinalize]                                              , 'number value turned to 1st, 2nd, 3rd, 4th etc.',
        '1',
        '1st',
        is_string_formatter: true


    row :inflection, %i[ordinal]                                                , 'ordinal suffix that would be required for a number, eg. st, nd, rd, th',
        '1',
        'st',
        is_string_formatter: true

    row :inflection, %i[pluralize_by_number]                                    , 'use number/count to determine pluralization',
        test_case: {
          expected_value: '3 people',
          params: [
            {name: 'value', value: 'person'},
            {name: 'count', value: '3'},
            {name: 'format', value: 'number_word'}
          ],
          template: '{{$ALIAS$ value count format}}'
        }

    row :inflection, %i[pluralize plural]                                        , 'singular value is converted to plural form',
      'category',
        'categories',
        is_string_formatter: true

    row :inflection, %i[singularize singular]                                    , 'plural value is converted to singular from',
        'categories',
        'category',
        is_string_formatter: true

    # ----------------------------------------------------------------------
    # :miscellaneous
    # ----------------------------------------------------------------------

    row :misc, %i[json]                                                         , 'value as JSON string',
        test_case: {
          expected_value: '{ "david": "was here" }',
          params: [
            {name: 'value', value: '{ "david": "was here" }'}
          ],
          template: '{{$ALIAS$ value}}'
        }

    row :misc, %i[safe]                                                         , 'value in safe string format',
        test_case: {
          expected_value: '"hello"',
          params: [
            {name: 'value', value: '"hello"'}
          ],
          template: '{{$ALIAS$ value}}'
        }

    row :misc, %i[noop raw]                                                     , 'NoOp is a wrapper for blocks that does nothing, it is useful with the raw output operator',
        test_case: {
          expected_value: '{{no_parse}}',
          params: [ ],
          template: '{{{{$ALIAS$}}}}{{no_parse}}{{{{/$ALIAS$}}}}'
        }
    # ----------------------------------------------------------------------
    # :misc
    # ----------------------------------------------------------------------
    
    # ----------------------------------------------------------------------
    # :string_formatting
    # ----------------------------------------------------------------------
    row :string, %i[format_as]                                                , 'returns a value that has been processed by multiple formatters',
        test_case: {
          expected_value: 'the-quick-brown-foxes',
          params: [
            {name: 'value', value: 'the quick brown fox'},
            {name: 'format', value: 'pluralize,dashify'}
          ],
          template: '{{$ALIAS$ value format}}'
        }

    row :string, %i[back_slash backward_slash slash_backward]                , 'convert to back slash notation',
        'the quick brown fox',
        'the\quick\brown\fox',
        is_string_formatter: true
    row :string, %i[camel camel_upper camelUpper camelU pascalcase]          , 'convert to camel case with first word uppercase and following words uppercase',
        'the quick brown fox',
        'TheQuickBrownFox',
        is_string_formatter: true
    row :string, %i[constantize constant]                                    , 'convert to constant case',
        'the quick brown fox',
        'THE_QUICK_BROWN_FOX',
        is_string_formatter: true
    row :string, %i[dasherize dashify dashcase hyphenate]                    , 'convert to dash notation',
        'the quick brown fox',
        'the-quick-brown-fox',
        is_string_formatter: true
    row :string, %i[dotirize dotify dotcase]                                 , 'convert to dash notation',
        'the quick brown fox',
        'the.quick.brown.fox',
        is_string_formatter: true
    row :string, %i[double_colon]                                            , 'double_colon notation, similar to ruby namespace',
        'the quick brown fox',
        'the::quick::brown::fox',
        is_string_formatter: true
    row :string, %i[downcase lowercase]                                      , 'convert all characters to lower case',
        'THE QUICK BROWN FOX',
        'the quick brown fox',
        is_string_formatter: true
    row :string, %i[humanize capitalize]                                     , 'convert text to human case, aka capitalize',
        'the Quick Brown Fox',
        'The quick brown fox',
        is_string_formatter: true
    row :string, %i[lamel camel_lower camelLower camelL]                     , 'convert to lamel case with first word lowercase and following words uppercase',
        'The quick brown fox',
        'theQuickBrownFox',
        is_string_formatter: true
    row :string, %i[pluserize plusify pluscase]                              , 'convert to plus notation',
        'the quick brown fox',
        'the+quick+brown+fox',
        is_string_formatter: true
    row :string, %i[slash forward_slash slash_forward]                       , 'convert to slash notation, aka forward slash',
        'the Quick brown Fox',
        'the/Quick/brown/Fox',
        is_string_formatter: true
    row :string, %i[snake]                                                   , 'convert to snake notation',
        'the quick brown fox',
        'the_quick_brown_fox',
        is_string_formatter: true
    row :string, %i[titleize heading capitalize_all]                         , 'value converted to titleize case, aka heading case',
        'the quick brown fox',
        'The Quick Brown Fox',
        is_string_formatter: true
    row :string, %i[upcase uppercase]                                        , 'convert all characters to lower case',
        'The quick brown fox',
        'THE QUICK BROWN FOX',
        is_string_formatter: true

    row :string, %i[padr pad_right ljust]                                              , 'returns value with padding to right',
        test_case: {
          expected_value: 'pad-me....',
          params: [
            {name: 'value', value: 'pad-me'},
            {name: 'count', value: 10},
            {name: 'char', value: '.'}
          ],
          template: '{{$ALIAS$ value count char}}'
        }

    row :string, %i[padl pad_left rjust]                                              , 'returns value with padding to left',
        test_case: {
          expected_value: '....pad-me',
          params: [
            {name: 'value', value: 'pad-me'},
            {name: 'count', value: 10},
            {name: 'char', value: '.'}
          ],
          template: '{{$ALIAS$ value count char}}'
        }

    row :string, %i[prepend_if prefix_if]                                              , 'returns value with prefix if the value is present?',
        test_case: {
          expected_value: '# product_categories',
          params: [
            {name: 'value', value: 'product category'},
            {name: 'prefix', value: '# '},
            {name: 'formats', value: 'pluralize,snake'}
          ],
          template: '{{$ALIAS$ value prefix formats}}'
        }

    row :string, %i[append_if suffix_if]                                              , 'returns value with suffix if the value is present?',
        test_case: {
          expected_value: 'product_categories:',
          params: [
            {name: 'value', value: 'product category'},
            {name: 'suffix', value: ':'},
            {name: 'formats', value: 'pluralize,snake'}
          ],
          template: '{{$ALIAS$ value suffix formats}}'
        }

      row :string, %i[surround_if surround_if_value]                                              , 'returns value with surrounding prefix/suffix if the value is present?',
        test_case: {
          expected_value: '(product_categories)',
          params: [
            {name: 'value', value: 'product category'},
            {name: 'prefix', value: '('},
            {name: 'suffix', value: ')'},
            {name: 'formats', value: 'pluralize,snake'}
          ],
          template: '{{$ALIAS$ value prefix suffix formats}}'
        }

      row :string, %i[surround]                                                         , 'returns value with surrounding prefix/suffix',
        test_case: {
          expected_value: '()',
          params: [
            {name: 'value', value: nil},
            {name: 'prefix', value: '('},
            {name: 'suffix', value: ')'},
            {name: 'formats', value: ''}
          ],
          template: '{{$ALIAS$ value prefix suffix formats}}'
        }
    # ----------------------------------------------------------------------
    # :comparison
    # ----------------------------------------------------------------------

    row :comparison, %i[default]                                          , 'return value or default value',
        test_case: {
          expected_value: 'hello world',
          params: [
            {name: 'p1', value: nil},
            {name: 'p2', value: nil}
          ],
          template: '{{$ALIAS$ p1 p2 "hello world"}}'
        }

    row :comparison, %i[or any]                                           , 'return block when first value is truthy',
        test_case: {
          expected_value: 'param2',
          params: [
            {name: 'p1', value: nil},
            {name: 'p2', value: 'param2'}
          ],
          template: 
          %Q(
            {{~#if ($ALIAS$ p1 p2)~}}
              {{p1}}{{p2}}
            {{~/if~}}
            )
        }

    row :comparison, %i[and all]                                           , 'return block when first value is truthy',
        test_case: {
          expected_value: 'all params exist',
          params: [
            {name: 'p1', value: 'param1'},
            {name: 'p2', value: 'param2'}
          ],
          template: 
          %Q(
            {{~#if ($ALIAS$ p1 p2)~}}
              all params exist
            {{~/if~}}
            )
        }

    row :comparison, %i[eq equal]                                          , 'return block when two values are equal',
        test_case: {
          expected_value: 'params are equal',
          params: [
            {name: 'p1', value: 'david'},
            {name: 'p2', value: 'david'}
          ],
          template: 
          %Q(
            {{~#if ($ALIAS$ p1 p2)~}}
            params are equal
            {{~/if~}}
            )
        }

    row :comparison, %i[ne not_equal]                                          , 'return block when two values are NOT equal',
        test_case: {
          expected_value: 'params are not equal',
          params: [
            {name: 'p1', value: 'aaa'},
            {name: 'p2', value: 'bbb'}
          ],
          template: 
          %Q(
            {{~#if ($ALIAS$ p1 p2)~}}
            params are not equal
            {{~/if~}}
            )
        }

    row :comparison, %i[lt less_than]                                          , 'return block when first parameter is less than second paramater',
        test_case: {
          expected_value: '1 is less than 2',
          params: [
            {name: 'p1', value: 1},
            {name: 'p2', value: 2}
          ],
          template: 
          %Q(
            {{~#if ($ALIAS$ p1 p2)~}}
            1 is less than 2
            {{~/if~}}
            )
        }

    row :comparison, %i[lte less_than_or_equal_to]                            , 'return block when first parameter is less than or equal to second paramater',
        test_case: {
          expected_value: '1 is less than or equal 1',
          params: [
            {name: 'p1', value: 1},
            {name: 'p2', value: 1}
          ],
          template: 
          %Q(
            {{~#if ($ALIAS$ p1 p2)~}}
            1 is less than or equal 1
            {{~/if~}}
            )
        }

    row :comparison, %i[gt greater_than]                                      , 'return block when first parameter is greater than second paramater',
        test_case: {
          expected_value: '2 is greater than 1',
          params: [
            {name: 'p1', value: 2},
            {name: 'p2', value: 1}
          ],
          template: 
          %Q(
            {{~#if ($ALIAS$ p1 p2)~}}
            2 is greater than 1
            {{~/if~}}
            )
        }

    row :comparison, %i[gte greater_than_or_equal_to]                         , 'return block when first parameter is greater than or equal to second paramater',
        test_case: {
          expected_value: '1 is greater than or equal 1',
          params: [
            {name: 'p1', value: 1},
            {name: 'p2', value: 1}
          ],
          template: 
          %Q(
            {{~#if ($ALIAS$ p1 p2)~}}
            1 is greater than or equal 1
            {{~/if~}}
            )
        }


    # ----------------------------------------------------------------------
    # :ruby_code
    # ----------------------------------------------------------------------
    row :ruby, %i[classify]                         , 'return class name from a plural table name like Rails does for table names to models',
        test_case: {
          expected_value: 'ProductCategory',
          params: [
            {name: 'table_name', value: 'product_categories'}
          ],
          template: '{{$ALIAS$ table_name}}'
        }

    row :ruby, %i[demodulize]                         , 'removes the module part from the expression in the string',
        test_case: {
          expected_value: 'Inflections',
          params: [
            {name: 'namespaced_class', value: 'ActiveSupport::Inflector::Inflections'}
          ],
          template: '{{$ALIAS$ namespaced_class}}'
        }

    row :ruby, %i[deconstantize]                     , 'remove the rightmost segment from the constant expression in the string',
        test_case: {
          expected_value: 'Net',
          params: [
            {name: 'constant_expression', value: 'Net::HTTP'}
          ],
          template: '{{$ALIAS$ constant_expression}}'
        }

    row :ruby, %i[foreign_key]                     , 'creates a foreign key name from a class name.',
        test_case: {
          expected_value: 'message_id',
          params: [
            {name: 'class_name', value: 'Message'}
          ],
          template: '{{$ALIAS$ class_name}}'
        }

    row :ruby, %i[tableize]                        , 'creates the name of a table like Rails does when converting models to table names',
        test_case: {
          expected_value: 'product_categories',
          params: [
            {name: 'model_name', value: 'product_category'}
          ],
          template: '{{$ALIAS$ model_name}}'
        },
        is_string_formatter: true
  end

  instructions do
    fields [:template_name, f(:output, '$TEMPLATE_NAME$'), f(:command, 'generate'), f(:active, true), f(:conflict, 'overwrite'), f(:after_write, 'open')]

    row '.handlebars_helpers.json', after_write: 'prettier,open'
    row '.handlebars_string_formatters.json', after_write: 'prettier,open'
    row 'all_helper_spec.rb', 'spec/handlebars/helpers/$TEMPLATE_NAME$', after_write: 'prettier,open'
  end

  is_run = 1

  def on_action
    x = raw_data_struct

    if false
      L.error 'convert new groups to helper groups'
      write_clipboard template: <<~TEXT
      {{#each new_groups.rows}}
        row :{{key}}, true,
            :{{name}},
            'handlebars/helpers/{{name}}',
            'Handlebars::Helpers::{{camelU name}}',
            '{{description}}',
            examples: [{{#each examples}}'{{.}}'{{#if @last}}{{else}}, {{/if}}{{/each}}]
      {{/each}}
      TEXT
      return
    end

    groups = x.helper_groups.rows.map do |group|
      {
        **group.to_h.except(:key),
        helpers: x.helpers.rows.select { |helper| group.key == helper.group && (true || helper.names.first == :or) }.map do |helper|
            name = helper.names.first
          {
            name: name,
            description: helper.description,
            test_in: helper.test_in,
            test_out: helper.test_out,
            tests: build_tests(helper),
            aliases: helper.names,
            require_path: "#{group[:base_require]}/#{name}",
            class_namespace: "#{group[:base_namespace]}::#{name.to_s.camelize}",
            is_string_formatter: helper.is_string_formatter
          }
        end
      }
    end

    string_formatters = []

    groups.each do |group|
      formatters = group[:helpers].select { |helper| helper[:is_string_formatter] }
                                  .map { |helper| helper.slice(:name, :description, :aliases, :class_namespace, :require_path) }

      formatters.each do |formatter|
        string_formatters.push formatter
      end
    end

    string_formatters = KDsl::Util.data.struct_to_hash(KDsl::Util.data.to_struct(string_formatters))

    # write_json is_edit: true, custom_data: string_formatters
    # write_json is_edit: true, custom_data: groups

    run_blueprint microapp: import(:handlebars_helpers, :microapp),
                  helper_groups: groups,
                  string_formatters: string_formatters
  end if is_run == 1

  def build_tests(helper)
    result = []

    helper.names.each do |name|
      test_case = helper.test_case.to_h
      test_case[:template] = test_case[:template].gsub('$ALIAS$', name.to_s) if test_case[:template]

      result.push({
        alias: name,
        **test_case
      })
    end

    result
  end

  L.warn 'set is_run to true if you want to run the action' if is_run == 0
end
