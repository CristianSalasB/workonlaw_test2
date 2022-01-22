Rails.application.routes.draw do
  resources :datos

  namespace 'test' do

    namespace 'workonlaw' do

      resources :lawyers

    end

  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
