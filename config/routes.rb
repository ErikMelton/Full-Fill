Rails.application.routes.draw do
  root 'homepage#index'
  get 'homepage/signin'

  devise_for :clients
  get 'dashboard/index' => 'dashboard#index'
end