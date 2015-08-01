Rails.application.routes.draw do

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  get 'account_safe' => 'welcome#account_safe'

  scope module: 'frontend' do
    scope module: 'users' do

      controller 'registrations' do
        get 'sign_up' => :new
        post 'sign_up' => :create
      end

      controller 'sessions' do
        get 'sign_in' => :new
        post 'sign_in' => :create
        delete 'sign_out' => :destroy
      end

      resources :passwords, only: [:new, :create]
      resources :activations, only: [:new, :create]

      controller 'safety_questions' do
        get 'safety_questions/edit' => :edit
        patch 'safety_questions/update' => :update
      end

      resources :binding_emails, only: [:index, :show, :create]
    end
  end

  controller 'frontend/users/profile' do
    get 'users/profile' => :show
    get 'users/profile/edit' => :edit
    patch 'users/profile/update' => :update
  end

  controller 'frontend/users/verification_codes' do
    post 'verification_codes' => :create
  end

  controller 'frontend/users/passwords_recovery' do
    get 'users/forget_password' => :new
    post 'users/get_otp_code' => :get_otp_code
    post 'users/verification_password' => :create
    get 'users/new_password' => :new_password
    post 'users/password/update' => :update
  end

  controller 'frontend/users/addresses' do
    get 'users/addresses' => :index
    post 'users/addresses/create' => :create
    get 'users/addresses/new' => :new
    get 'users/addresses/edit' => :edit
    patch 'users/addresses/update' => :update
    delete 'users/address' => :destroy
  end


  #省市级联
  mount ChinaCity::Engine => '/china_city'

  scope :admin, module: :backend, as: :admin do
    resources :users

    get "sign_in", to: "sessions#new"

    resources :properties
    resources :product_properties, controller: 'properties'

    resources :prototypes
    resources :product_prototypes, controller: 'prototypes'

    resources :option_types
    resources :product_option_types, controller: 'option_types'
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
