# frozen_string_literal: true

# {{name}}
class ConnectedApplicationPresenter < BasePresenter
  include Rails.application.routes.url_helpers

  # fields
  def present(_context)
    {
      id: object.id,
      name: object.name,
      provider: object.provider
    }
  end
end
