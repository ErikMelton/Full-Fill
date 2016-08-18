Rails.application.routes.draw do
  get 'report/index'

  get 'tell_more/index'

  get 'visualize/index'

  get 'visualize/report'

  root 'homepage#index'
  get 'homepage/signin'

  devise_for :clients, :controllers => {:registrations => "clients/registrations"}
  get 'dashboard/index' => 'dashboard#index'
  resources :events
  get 'dashboard/add_event' => 'dashboard#add_event'
  get 'signed_in' => 'homepage#signed_in'
end