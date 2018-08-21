Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :challenges, only: [:index, :create]

  get 'conjugate/(:verb)', only: :show, controller: :conjugations, action: :show, as: :conjugation

  root 'challenges#index'
end
