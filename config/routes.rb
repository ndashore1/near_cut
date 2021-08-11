Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'users#upload'
  resources :users, only: :create do
    collection do
      get 'sample_csv', defaults: { format: 'csv' }
    end
  end
end
