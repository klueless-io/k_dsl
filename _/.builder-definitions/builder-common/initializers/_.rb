require 'k_log'
require 'k_util'

include KLog::Logging

log.section_heading 'load started...' if AppDebug.require?
log.warn 'initializers' if AppDebug.require?

require_relative './handlebars_helpers'
