SampleApp::Application.routes.draw do

  resources :users
  resources :answers

  resources :questions do
    member do
      get 'show_questions'
    end
  end

  resources :questionnaires do 
  member do 
    get 'open'
    get 'close'
    get 'new_questions'
  end
end
  resources :sessions, only: [:new, :create, :destroy]

  root to: 'static_pages#home'
  match '/help',    to: 'static_pages#help',    via: 'get'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
  match '/create_url', to: 'static_pages#qrcode', via: 'get'
  match '/home', to: 'static_pages#home', via: 'get'

  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'

  match '/create_questionnaire', to: 'questionnaires#new', via: 'get'
  match '/my_questionnaires', to: 'questionnaires#my_questionnaires', via: 'get'
  match '/my_answered_questionnaires', to: 'questionnaires#my_answered_questionnaires', via: 'get'
  match '/answer_successfully', to: 'questions#get_answer', via: 'get'
  #match '/add_questions', to: 'questions#add_questions', via: 'get'
  #match '/add_questions', to: 'questions#create', via: 'post'
  #match '/add_questions', to: 'questions#new', via: 'get'

 

  #match '/open_questionnaire/', to: 'questionnaires#open', via: 'get'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
