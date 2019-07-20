Rails.application.routes.draw do

  devise_for :pharmacies, :controllers => { :registrations => "pharmacies/registrations" }
  devise_scope :pharmacy do
    get '/pharmacy/login', to: 'devise/sessions#new'
    get '/pharmacy/registration', to: 'devise/registrations#new'
    get '/password/settings', to: 'pharmacies/registrations#edit'
    get '/retrieve/password', to: 'devise/passwords#new'
  end
  get '/pharmacy/settings', to: 'pharmacies#edit'
  get '/pharmacy/dashboard', to: 'pharmacies#dashboard'
  authenticated :pharmacy do
    root 'pharmacies#dashboard', as: :authenticated_pharmacy_root
  end
  
  devise_for :patients, :controllers => { :registrations => "patients/registrations" }
  devise_scope :patient do
    get '/patient/login', to: 'devise/sessions#new'
    get '/patient/signup', to: 'devise/registrations#new'
    get '/password/settings', to: 'patients/registrations#edit'
    get '/retrieve/password', to: 'devise/passwords#new'
  end
  get '/patient/dashboard', to: 'patients#dashboard'
  # authenticated :patient do
  #   root '/getting-started', as: :authenticated_patient_root
  # end
  
  
  get '/check-status', to: 'patients#check_status'
  get '/request-refill', to: 'patients#request_refill'
  get '/patients', to: 'patients#patients'
  get '/getting-started', to: 'pages#getting_started'
  
  resources :pharmacies, except: :index
  
  root 'pages#home'
end
