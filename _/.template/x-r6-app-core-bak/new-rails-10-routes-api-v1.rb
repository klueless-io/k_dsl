# config/routes/api_v1.rb
namespace :api, defaults: {format: 'json'} do
  namespace :v1 do

{{#each models}}
    resources :{{snake names}} do
      collection do
        get 'multi'
        get 'sample'
      end
    end

{{/each}}
  end
end
