Rails.application.routes.draw do

  devise_for :pharmacies, :controllers => { :registrations => "authentication/pharmacies/registrations" }
  devise_scope :pharmacy do
    get '/pharmacy/login', to: 'devise/sessions#new'
    get '/pharmacy/registration', to: 'devise/registrations#new'
    get '/password/settings', to: 'authentication/pharmacies/registrations#edit'
    get '/retrieve/password', to: 'devise/passwords#new'
  end
  authenticated :pharmacy do
    root 'main/pharmacies#dashboard', as: :authenticated_pharmacy_root
  end
  
  devise_for :patients, :controllers => { :registrations => "authentication/patients/registrations" }
  devise_scope :patient do
    get '/patient/login', to: 'devise/sessions#new'
    get '/patient/signup', to: 'devise/registrations#new'
    get '/password/settings', to: 'authentication/patients/registrations#edit'
    get '/retrieve/password', to: 'devise/passwords#new'
  end
  authenticated :patient do
    root 'patients#dashboard', as: :authenticated_patient_root
  end
  
  
  scope module: "main" do
    get '/check-status', to: 'patients#check_status'
    get '/request-refill', to: 'patients#request_refill'
    get '/patients', to: 'patients#patients'
    get '/getting-started', to: 'pages#getting_started'
    get '/patient/dashboard', to: 'patients#dashboard'
    
    get '/pharmacy/settings', to: 'pharmacies#edit'
    get '/pharmacy/dashboard', to: 'pharmacies#dashboard'
    get '/requests/status', to: 'pharmacies#status_requests'
    get '/requests/refill', to: 'pharmacies#refill_requests'
    post '/update_rx_status', to: 'pharmacies#update_rx_status'
    get '/load_chart', to: 'pharmacies#load_chart'
  end
  
  namespace :api do
    get '/twilio_trigger', to: 'api#twilio_trigger'
  end
  
  resources :pharmacies, except: :index
  root 'main/pages#home'
  
end
