Rails.application.routes.draw do
 
  get 'bookings/:center_id/:id/index' => 'bookings#index', as: 'book_now'
  post 'bookings/create'
  get 'bookings/:center_id/:id/add_details' => 'bookings#add_details', as: 'add_details'

  post '/rate' => 'rater#create', :as => 'rate'
  namespace :partners do
    resources :centers do
      scope module: 'centers' do
        resources :details, :accounts, :instructors, :services, :photos
      end
    end
  end
  
  get 'customerdashboard/details'
  patch 'customerdashboard/details_update'

  get 'customerdashboard/pass'

  get 'customerdashboard/bookings'

  get 'customerdashboard/transactions'

  get 'customerdashboard/preferences'

  get 'customerdashboard/referral'

  get 'pages/about'

  get 'pages/partners'

  get 'pages/license'

  get 'pages/terms'

  get 'sessions/partner'
  post 'sessions/partner_auth'
  
  get 'sessions/customer'
  post 'sessions/customer_auth', :as => 'customer_auth'
  get 'sessions/customer_logout'
  get 'sessions/checker'

  get 'registrations/partner'
  post 'registrations/partner_signup', :as => 'partner_signup'

  get 'registrations/customer'
  post 'registrations/customer_signup', :as => 'customer_signup'

  get 'centers/:center_id/about' => 'centers#about', :as => 'center_about'
  get 'centers/:center_id/services' => 'centers#services', :as => 'center_services'
  get 'centers/:center_id/map' => 'centers#map', :as => 'center_map'
  get 'centers/:center_id/reviews' => 'centers#reviews', :as => 'center_reviews'
  get 'centers/:center_id/instructors' => 'centers#instructors', :as => 'center_instructors'
  get 'centers/:center_id/experience' => 'centers#experience', :as => 'center_experience'
  get 'centers/:center_id/hours' => 'centers#hours', :as => 'center_hours'
  get 'centers/:center_id/upcoming' => 'centers#upcoming', :as => 'center_upcoming'

  get 'filters/index'

  get 'filters/list'

  get 'filters/grid'

  get 'filters/map'

  get 'homepage/index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'homepage#index'

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
