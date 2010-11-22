Refinery::Application.routes.draw do
  resources :tutorials

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :tutorials do
      collection do
        post :update_positions
      end
    end
  end
end
