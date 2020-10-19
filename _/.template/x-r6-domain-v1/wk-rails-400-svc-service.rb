# {{camelU settings.Model}}Service provides light weight access to actions related to '{{titleize (humanize settings.Model) }}'
#
# Use these service actions from your controllers, other business objects and state change events throughout the application
#
# Keep these actions simple, delegate any complex code to specialized classes or subsystems that can be called from these actions
#
# Patterns: Facade Pattern, Micro Service
class {{camelU settings.Model}}Service

  def initialize()
  end

  # --------------------------------------------------------------------------------
  # Service Actions
  # --------------------------------------------------------------------------------
  def self.some_action()
    return 'light weight action'
  end

end
