Rails.application.routes.draw do
  devise_for :users
  root to: "cocktails#index"

  resources :cocktails, only: [ :show, :new, :create, :edit, :update ] do
    resources :doses, only: [ :new, :create, :edit, :update, :destroy ]
  end
end
