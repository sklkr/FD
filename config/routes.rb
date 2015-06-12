Rails.application.routes.draw do

  mount Commontator::Engine => '/commontator'

  get 'errors/file_not_found'

  get 'errors/unprocessable'

  get 'errors/internal_server_error'

 constraints :subdomain => 'blog' do
  mount Monologue::Engine, at: '/'
 end


  constraints :subdomain => "partners" do
    scope :module => 'partners', :as => 'partners' do
      # constraints(Subdomain) do
        # resources :centers do
         # scope module: 'centers' do
          #  resources :details, :accounts, :instructors, :photos, :centermanagers
           # resources :services do
            #  collection do
             #   get :upcoming
             # end
            #end
          #end
        #end
        # scope module: 'multicenters' do
         # resources :configurations, :profiles, :customers, :payments, :reports
        # end
        # resources :customermanagers
        # resources :paymentmanagers do
          # collection do
           # get 'summary'
           # get 'commission'
           # get 'transactions'
           # get 'partner_payment'
          # end
        #end
        resources :instructors
        resources :classes
        resources :centers do
          resources :services, :galleries
        end
        resources :orders, :only => [:index, :show]
        resource :reservations
        resource :settings

        post 'login' => 'sessions#create'
        # match 'login/reset' => 'sessions#reset', :via => [:get, :post]
        delete 'logout' => 'sessions#destroy'
        # match '/' => 'dashboard#index', via: [:get]
        match '/' => 'sessions#new', via: [:get]
      #   end
    end
  end

        get 'settings/change_password' => 'partners/settings#change_password', :as => 'change_password_partners_settings', :subdomain => 'partners'

# Frontend Resources
resources :customers, only: [:new, :create]
resources :partners, only: [:index, :new, :create]


  # mount Lockup::Engine, at: '/lockup'

  get 'mypackage' => 'mypackage#index'
  post 'mypackage/success'
  post 'mypackage/failure'

  get 'checkout' => 'checkout#step1', :as => 'checkout'
  post 'checkout' => 'checkout#create'
  get 'checkout/step2'
  get 'checkout/success'
  # Fresh routes for details page
  get 'details/:center' => 'details#index', as: 'details_page'

  get 'payments/index'
  post 'payments/success'
  post 'payments/failure'

  get 'bookings/:center_id/:id/index' => 'bookings#index', as: 'book_now'
  post 'bookings/create'
  get 'bookings/:center_id/:id/add_details' => 'bookings#add_details', as: 'add_details'

  post '/rate' => 'rater#create', :as => 'rate'

  namespace :admins do
    resources :customers, :partners, :approvals, :populars
    resource :sessions
    get 'partners/list/index' => 'partners#list'
    post 'partners/list/:id' => 'partners#setpassword'
  end


  get 'partners(/:id)/dashboard' => 'partners/dashboard#summary', :as => 'partners_dashboard'

  get 'customerdashboard/details'
  patch 'customerdashboard/details_update'

  resources :categories, :only => [] do
    resources :populars, :only => [:index, :create]
  end

  namespace :customers do
    resources :details, :bookings, :mypass, :classes
    resources :profiles, only: [:edit, :update]

  end
  resources :reserves

  resources :sessions, :only => [:new, :create, :destroy]
  # Oauth Routes
  get 'auth/facebook/callback' => 'sessions#facebook'

  #password Resets
  resources :password_resets
  get 'customer/change_password' => 'password_resets#change_password'
  patch 'customer/update_password' => 'password_resets#update_password'

  get 'registrations/partner'
  post 'registrations/partner_signup', :as => 'partner_signup'


  get 'registrations/verify_email/:token' => 'registrations#verify_email', :as => 'registrations_verify_email'
  get 'registrations/customer'
  post 'registrations/customer_signup', :as => 'customer_signup'


  resources :centers, :only => [] do
    member do
      get :about
      get :map
      get :reviews
      get :instructors
      get :experience
      get :hours
      get :upcoming
    end
    resources :categories, :only => [] do
      resources :services, :only => [:index]
    end
  end

  # get 'filters/index'
  # get 'filters/list(/:category_id)' => 'filters#list', :as => 'filters_list'
  # get 'filters/grid(/:category_id)' => 'filters#grid', :as => 'filters_grid'
  # get 'filters/map'
  get 'search' => 'filters#search'
  get 'classes/search' => 'filters#classes'
  post 'api/search' => 'filters#react_search'
  post 'api/search/classes' => 'filters#react_class_search'
  get 'api/center_types' => 'filters#center_types'
  get 'api/dates' => 'filters#dates'

  get 'homepage/index'
  get 'centers/list' => 'homepage#centers_list'



  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api' }, path: '/'  do
      scope module: :v1 do
         # We are going to list our resources here
      end
  end


  get "cities/:city_id/areas" => "application#areas", :as => "areas", :format => :json

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"


  root :to => 'homepage#index'

  if Rails.env.production?
    match '/404', to: 'errors#file_not_found', via: :all
    match '/422', to: 'errors#unprocessable', via: :all
    match '/500', to: 'errors#internal_server_error', via: :all
  end

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
