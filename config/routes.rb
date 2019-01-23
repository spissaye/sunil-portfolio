Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "home#index"

  post 'contact', to: 'home#contact', as: 'contact'
end

if Rails.env.development?
  require 'sidekiq/web'
  Rails.application.routes.draw do
    mount Sidekiq::Web => '/sidekiq'
  end
end