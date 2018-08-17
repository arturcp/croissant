Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :challenges, only: :index
  resources :conjugations, only: :show, path: 'conjugate', param: :verb

  root 'challenges#index'
end
