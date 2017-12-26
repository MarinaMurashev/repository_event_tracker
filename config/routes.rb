Rails.application.routes.draw do
 namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :repo_events, only: [:index]
    end
  end
end
