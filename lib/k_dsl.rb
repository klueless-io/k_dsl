# frozen_string_literal: true

require 'logger'

require 'k_dsl'
require 'k_dsl/version'

# Log helpers (move to own GEM)
require 'k_dsl/logger/log_formatter'
require 'k_dsl/logger/log_helper'
require 'k_dsl/logger/log_util'

# Memory management for DSLs
require 'k_dsl/manage/project'
require 'k_dsl/manage/project_config'
require 'k_dsl/manage/register'

# DSL document structures
require 'k_dsl/model/document'
require 'k_dsl/model/table'
require 'k_dsl/model/settings'

# Data decorators
require 'k_dsl/decorator/helper'
require 'k_dsl/decorator/lowercase_decorator'
require 'k_dsl/decorator/uppercase_decorator'

# General configuration
require 'k_dsl/configuration'

# Klue DSL
module KDsl
  class << self
    attr_accessor :logger
  end

  class Error < StandardError; end
  class InvalidTypeError < KDsl::Error; end
end

KDsl.logger = Logger.new(STDOUT)
KDsl.logger.level = Logger::DEBUG
KDsl.logger.formatter = KDsl::Logger::LogFormatter.new

L = LogUtil.new(KDsl.logger)
