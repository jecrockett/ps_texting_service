Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :messages, only: [:create]
      post "delivery_status", to: "message_sends#delivery_status"
    end
  end
end
