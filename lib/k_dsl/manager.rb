# frozen_string_literal: true

# Module method stores single instance manager which can handle multiple projects if needed
module KDsl
  # Manager is used to manage active projects and memory management
  class << self
    attr_accessor :manager
  end
end

# REFACT: IS this needed
KDsl.manager = KDsl::Manage::ProjectManager.new
