Rails.application.routes.draw do

  resources :used_times
  resources :goals

  resources :ut_types
  resources :tasks
  resources :otdels
  resources :priorities

  resources :users
  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'                                   
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  get    'options'  => 'options#edit'
  get    'options/:options_page'  => 'options#edit',:constraints => {:format => /(json|html)/}
  post   'options/:options_page' => 'options#create'
  delete 'options/:options_page/:id' => 'options#destroy'

  post "ajax/save_last_time"
  post "ajax/save_new_otdel"
  post "ajax/save_new_task"
  post "ajax/upd_param"
  post "ajax/goal_today"
  post "ajax/goal_tomorrow"
  post "ajax/goal_sort"
  root :to => "goals#index"


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
