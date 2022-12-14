Rails.application.routes.draw do
  root to: 'timesheets#index'
  devise_for :users, controllers: {registrations: 'users/registrations', sessions: 'users/sessions'}
  resources :timesheets
  resources :pages
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
