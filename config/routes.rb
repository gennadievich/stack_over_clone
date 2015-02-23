Stack::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".


  root 'questions#index_15'
  get  '/questions/search_questions/:tag_id' => 'questions#search_questions_by', as: 'search_questions'
  get  '/questions/sort_by_rating' => 'questions#sort_by_rating', as: 'sort_by_rating'

  resources :users
  resources :questions do
    resources :answers do
      resources :votes
    end
    resources :votes
  end
  resources :tags

  get  'votes/perform_vote_for/:what, :id, :how' => 'votes#perform_vote_for', as: 'perform_vote_for'

  get  '/login'   => 'sessions#index', as: 'login'
  post '/login'   => 'sessions#create'
  get  '/logout'  => 'sessions#destroy', as: 'logout'
  post '/questions/new' => 'questions#create'


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
