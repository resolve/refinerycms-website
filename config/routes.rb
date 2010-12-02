RefinerycmsWebsite::Application.routes.draw do
  
  match "/inquiries/new" => redirect("/contact")
  match "/blog/author/Barry Harrison" => redirect("/blog")
  match "/blog/author/Patrick" => redirect("/blog")
  match "/blog/award-updates" => redirect("/blog/awards-updates")
  match "/blog/category/Releases" => redirect("/blog")
  match "/blog/hosting-deploying-refinery-on-heroku" => redirect("/blog/deploying-refinery-on-heroku")
  match "/blog/open-source-awards" => redirect("/blog/resolve-digital-is-a-finalist-in-the-2010-new-zealand-open-source-awards")
  match "/blog/plugin" => redirect("/engines")
  match "/blog/refinery-cms-0-9-7-released" => redirect("/blog/whats-new-in-refinery-097")
  match "/blog/refinery-cms-supports-rails-3" => redirect("/blog/refinery-cms-now-supports-rails-3")
  match "/blog/refinery-in-the-news" => redirect("/blog/refinery-resolve-digital-in-the-news")
  match "/blog/refinery-live-support" => redirect("/blog")
  match "/blog/refineryhq-goes-live" => redirect("/blog/plunging-into-the-gaping-unknown-refineryhq-goes-live")
  match "/blog/tag/Hosting" => redirect("/blog/categories/hosting")
  match "/blog/tag/Rails" => redirect("/blog")
  match "/blog/tag/Rails3" => redirect("/blog/refinery-cms-now-supports-rails-3")
  match "/blog/tag/RefineryCMS" => redirect("/blog")
  match "/blog/tag/agile" => redirect("/blog")
  match "/blog/tag/coupons" => redirect("/blog")
  match "/blog/tag/iteration" => redirect("/blog")
  match "/developers" => redirect("/")
  match "/examples" => redirect("/showcase")
  match "/testimonials" => redirect("/community")
  match "/blog/an-overview-of-refinery-cms-rails-magazine" => redirect("/blog/rails-magazine-article-an-overview-of-refinery")
  match "/overview" => redirect("/")
  match "/blog/refinery-turns-you-into-a-web-design-super-hero" => redirect("/")
  match "/contact-page" => redirect("/contact")
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get :short
  #       post :toggle
  #     end
  #
  #     collection do
  #       get :sold
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get :recent, :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
