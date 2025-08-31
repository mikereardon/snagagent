Rails.application.routes.draw do
  # Admin UI (admins manage reporter users)
  namespace :admin do
    resource  :dashboard, only: :show           # /admin/dashboard
    resources :api_keys,  only: [ :create, :destroy, :index ]  # regenerate/list tokens
    resources :users,     only: [ :new, :create, :index ]
  end

  # Devise (custom registrations controller for admin sign-up w/ organisation)
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  # HTML app
  root "projects#index"
  resources :snags
  resources :projects

  # Health + PWA
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # JSON API (ngrok/Steve uses this)
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :projects, only: [ :index, :show ]
      resources :snags,    only: [ :index, :show, :create ]
    end
  end
end
