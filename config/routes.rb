Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: "cocktails#index"

  get '/search' => 'cocktails#search'

  resources :cocktails, only: [ :show, :new, :create, :edit, :update ] do
    resources :doses, only: [ :new, :create, :edit, :update]
  end
    resources :doses, only: [:destroy]

  %w( 404 422 500 ).each do |code|
    get code, :to => "errors#show", :code => code
  end
end
