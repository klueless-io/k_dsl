# Log formatter which only displays styled messages.
class LogFormatter < ::Logger::Formatter

  attr_accessor :show_caller

  def initialize(show_caller = false)
    @show_caller = show_caller
  end

  SEVERITY_TO_COLOR_MAP = {'DEBUG'=>'34', 'INFO'=>'32', 'WARN'=>'33', 'ERROR'=>'31', 'FATAL'=>'37'}

  # This method is invoked when a log event occurs
  def call(severity, timestamp, progname, msg)
    severity = severity.upcase

    color = SEVERITY_TO_COLOR_MAP[severity]

    severity_value = "\033[#{color}m%-5.5s\033[0m" % severity

    msg = String === msg ? msg : msg.inspect

    # callee = caller[4].split('/').last
    # callee = callee.split(':')[0,2].join(':')
    #
    # if callee.start_with?('logger') || callee.start_with?('log_')
    #   log_callee = ''
    #   log_callee = "[\033[01;36m#{callee}\033[0m]"
    # else
    #   log_callee = "[\033[01;36m#{callee}\033[0m]"
    # end

    if @show_caller
      # caller = "[\033[01;36m#{get_caller()}\033[0m]"

      caller = get_caller()
      message = "%-50s %s %s %s\n" % [caller, Time.now.strftime("%d|%H:%M:%S"), severity_value, msg]

    else
      message = "%s %s %s\n" % [Time.now.strftime("%d|%H:%M:%S"), severity_value, msg]
    end

    return message
  end

  # This is all a fudge for now, until I hfind a suitable solution
  # Probabally resolve with the semantic loggers
  def get_caller
    callee = ''

    caller.each do |item|

      if (item.include?('hiremeup-server') && !item.include?('format_logger'))
        callee = item.split('/').last
        callee = callee.split(':')[0,2].join(':')
        break
      end

    end

    return callee
  end

end