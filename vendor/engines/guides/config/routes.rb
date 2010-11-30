Refinery::Application.routes.draw do
  resources :guides

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :guides do
      collection do
        post :update_positions
      end
    end
  end
end
