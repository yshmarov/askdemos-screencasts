Rails.application.routes.draw do
  resources :messages
  devise_for :users
  resources :inboxes
  root 'static_pages#landing_page'
  get 'pricing', to: 'static_pages#pricing'
  get 'privacy', to: 'static_pages#privacy'
  get 'terms', to: 'static_pages#terms'
end
