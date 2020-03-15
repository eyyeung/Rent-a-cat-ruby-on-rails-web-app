Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :cats
  resources :cat_rental_requests, only: [:new,:create] do
    member do
      post :approve
      post :deny
    end
  end

  resources :users, only: [:new,:create, :show]

  resource :session, only: [:new,:create, :destroy]


  root to: redirect('/cats')

end
