RefinerycmsWebsite::Application.routes.draw do
  resources :guides, :only => [:index, :show]
  match 'edge-guides', :to => 'guides#index', :branch => 'master', :as => 'edge_guides'
  match 'edge-guides/:id', :to => 'guides#show', :branch => 'master', :as => 'show_edge_guides'

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :guides do
      collection do
        post :update_positions
      end
    end
  end

  # Github post-receive hook
  post '/guides/hook', :to => 'guides#hook'
end
