Rails.application.routes.draw do
  root to: "home#index"

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :repo_events, only: [:index]
    end
  end
end
