Rails.application.routes.draw do
  devise_for :users,
             controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  resources :inboxes do
    resources :messages, only: %i[create destroy], module: :inboxes do
      member do
        patch :upvote
        patch :change_status
      end
    end
  end
  root 'static_pages#landing_page'
  get 'pricing', to: 'static_pages#pricing'
  get 'privacy', to: 'static_pages#privacy'
  get 'terms', to: 'static_pages#terms'
end
