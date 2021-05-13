# frozen_string_literal: true

# config/routes/api_v1.rb
namespace :api, defaults: { format: "json" } do
  namespace :v1 do
{{#each entities}}
    resources :{{snake ./model_name_plural}} do
      collection do
        get "multi"
        get "sample"
      end
    end
{{#if @last}}{{else}}
{{/if}}
{{/each}}
  end
end
