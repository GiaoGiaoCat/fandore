Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  controller 'frontend/users/registrations' do
    get 'sign_up' => :new
    post 'sign_up' => :create
  end

  controller 'frontend/users/sessions' do
    get 'sign_in' => :new
    post 'sign_in' => :create
    delete 'sign_out' => :destroy
  end

  controller 'frontend/users/profile' do
    get 'users/profile' => :show
    get 'users/profile/edit' => :edit
    patch 'users/profile/update' => :update
  end

  controller 'frontend/users/verification_codes' do
    post '/verification_codes/create' => :create
  end


  scope :admin, module: :backend, as: :admin do
    resources :users
  end

  # Admin root path
  get 'admin', to: 'backend/dashboards#index'

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products




end
