Rails.application.routes.draw do
  root 'tasks#index'
  devise_for :users, path: '/', path_names: { sign_in: 'login', sign_up: 'register' }, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
end
