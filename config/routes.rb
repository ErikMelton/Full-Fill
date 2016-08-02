Rails.application.routes.draw do
  root 'homepage#index'
  get 'homepage/signin'

  devise_for :clients, :controllers => {:registrations => "clients/registrations"}
  get 'dashboard/index' => 'dashboard#index'
  get 'dashboard/add_event' => 'dashboard#add_event'
  post 'dashboard/add_event' => 'dashboard#add_events'
end