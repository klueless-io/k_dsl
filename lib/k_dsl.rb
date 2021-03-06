# frozen_string_literal: true

require 'logger'
require 'listen'
require 'active_support/core_ext/string'
require 'virtus'

require 'k_dsl/github/github_api'
require 'k_dsl/github/github_hook'
require 'k_dsl/github/github_printer'
require 'k_dsl/github/github_repository'

require 'k_dsl'

require 'k_dsl/version'
require 'k_dsl/dsl'
require 'k_dsl/exceptions'

# Log helpers (move to own GEM)
require 'k_dsl/logger/log_formatter'
require 'k_dsl/logger/log_helper'
require 'k_dsl/logger/log_util'
require 'table_print' # Debugging code needs to be decoupled from k_dsl

# Extensions
require 'k_dsl/extensions/create_dsl'
require 'k_dsl/extensions/command_runnable'
require 'k_dsl/extensions/github_linkable'
require 'k_dsl/extensions/http_resourceful'
require 'k_dsl/extensions/importable'
require 'k_dsl/extensions/writable'
require 'k_dsl/extensions/document_factories'

# TemplateRendering
require 'k_dsl/template_rendering/handlebars_formatter'
require 'k_dsl/template_rendering/handlebars_helper'
require 'k_dsl/template_rendering/template_helper'
require 'k_dsl/template_rendering/template_options'
require 'k_dsl/template_rendering/template_renderer'

# Project management for DSLs and other resources
require 'k_dsl/manage/project'
require 'k_dsl/manage/project_config'
require 'k_dsl/manage/project_manager'
require 'k_dsl/manage/register'

require 'k_dsl/peaky/method_signature'
require 'k_dsl/peaky/parameter_info'

# Artifact
require 'k_dsl/artifacts/artifact'

# Resources
require 'k_dsl/resources/resource'

# Resources / Factories
require 'k_dsl/resources/factories/document_factory'
require 'k_dsl/resources/factories/csv_document_factory'
require 'k_dsl/resources/factories/json_document_factory'
require 'k_dsl/resources/factories/ruby_document_factory'
require 'k_dsl/resources/factories/csv_document_factory'
require 'k_dsl/resources/factories/unknown_document_factory'
require 'k_dsl/resources/factories/yaml_document_factory'

# ResourceDocuments
require 'k_dsl/resource_documents/resource_document'

# DSL document structures
require 'k_dsl/model/document'
require 'k_dsl/model/table'
require 'k_dsl/model/settings'

# Advanced document structures
require 'k_dsl/model/blueprint_document'

# Data decorators
require 'k_dsl/decorator/helper'
require 'k_dsl/decorator/lowercase_decorator'
require 'k_dsl/decorator/uppercase_decorator'

# General configuration
require 'k_dsl/configuration'

# Manager
require 'k_dsl/manager'

# General utilities
require 'k_dsl/util/data_helper'
require 'k_dsl/util/dsl_helper'
require 'k_dsl/util/file_helper'
require 'k_dsl/util/format_helper'

# Klue DSL
module KDsl
  class << self
    attr_accessor :logger
  end
end

KDsl.logger = Logger.new(STDOUT)
KDsl.logger.level = Logger::DEBUG
KDsl.logger.formatter = KDsl::Logger::LogFormatter.new

L = LogUtil.new(KDsl.logger)
