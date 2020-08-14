Rails.application.routes.draw do
  devise_for :users, :controllers => { omniauth_callbacks: "users/omniauth_callbacks" }
  root to: "cocktails#index"

  get '/search' => 'cocktails#search'

  resources :cocktails, only: [ :show, :new, :create, :edit, :update ] do
    resources :doses, only: [ :new, :create, :edit, :update]
  end
    resources :doses, only: [:destroy]
end
