# Examples on how to use for inclusion into USAGE.MD
# ------------------------------------------------------------

KDsl.document :usage do
  def on_action
    # write_json is_edit: true
  end

  table :example_groups do
    fields [:key, :group, :description, f(:featured, false)]

    row :basic_example  , :basic_example          , '', featured: true
    row :sample         , :sample_classes         , ''
  end

  table :examples do
    # status: :done, :current, :backlog:
    # fields [f(:type, :story), f(:status, :todo), :story, :tasks, f(:featured_position, 0)]

    fields [:group_key, :name, :description, :ruby]

    row :basic_example, 'Setup KLog', <<~TEXT, ruby: <<~RUBY
      Pass a standard Logger to KLog and then setup an alias for easier access
    TEXT

    KLog.logger = Logger.new($stdout)
    KLog.logger.level = Logger::DEBUG
    KLog.logger.formatter = KLog::LogFormatter.new

    L = KLog::LogUtil.new(KLog.logger)

    RUBY

    row :basic_example, 'Sample Usage', '', ruby: <<~RUBY

    L.debug 'some debug message'
    L.info 'some info message'
    L.warn 'some warning message'
    L.error 'some error message'
    L.fatal 'some fatal message'

    L.kv('First Name', 'David')
    L.kv('Last Name', 'Cruwys')
    L.kv('Age', 45)
    L.kv('Sex', 'male')

    L.heading('Heading')
    L.subheading('Sub Heading')

    L.block ['Line 1', 12, 'Line 3', true, 'Line 5']

    L.progress(0, 'Section 1')
    L.progress
    L.progress

    RUBY

    row :basic_example, '', '![Usage](usage.png)'

    row :sample, 'Setup KLog', <<~TEXT, ruby: <<~RUBY
      Pass a standard Logger to KLog and then setup an alias for easier access
    TEXT

    KLog.logger = Logger.new($stdout)
    KLog.logger.level = Logger::DEBUG
    KLog.logger.formatter = KLog::LogFormatter.new

    L = KLog::LogUtil.new(KLog.logger)

    RUBY

    row :sample, 'Sample Usage', '', ruby: <<~RUBY

    L.debug 'some debug message'
    L.info 'some info message'
    L.warn 'some warning message'
    L.error 'some error message'
    L.fatal 'some fatal message'

    L.kv('First Name', 'David')
    L.kv('Last Name', 'Cruwys')
    L.kv('Age', 45)
    L.kv('Sex', 'male')

    L.heading('Heading')
    L.subheading('Sub Heading')

    L.block ['Line 1', 12, 'Line 3', true, 'Line 5']

    L.progress(0, 'Section 1')
    L.progress
    L.progress

    RUBY

    row :sample, '', '![Usage](usage.png)'

  end
end
