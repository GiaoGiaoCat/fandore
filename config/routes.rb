Rails.application.routes.draw do

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  get 'account_safe' => 'frontend/welcome#account_safe'
  get 'user_center' => 'frontend/welcome#user_center'


  concern :authenticatable do
    controller :sessions do
      get 'sign_in' => :new
      post 'sign_in' => :create
      delete 'sign_out' => :destroy
    end
  end

  scope module: 'frontend' do
    # 产品相关
    resources :products, only: [:index, :show] do
      scope module: 'users' do
        resources :favorites, only: [:create]
      end
    end

    # 购物相关
    resources :orders, only: [:new, :create, :update] do
      # resources :build, controller: 'orders/build'
      scope module: 'orders', only: [:show, :create] do
        resources :build, only: [:show, :update]
      end
    end
    resources :carts, only: [:show, :destroy]
    resources :line_items, only: [:create, :destroy] do
      scope module: 'orders', only: [:show, :create], shallow: true do
        resources :comments, only: [:new, :create, :show]
      end
    end

    # 会员相关
    scope module: 'users' do
      controller 'registrations' do
        get 'sign_up' => :new
        post 'sign_up' => :create
      end

      concerns :authenticatable

      resources :passwords, only: [:new, :create]
      resources :activations, only: [:new, :create]

      controller 'safety_questions' do
        get 'safety_questions/edit' => :edit
        patch 'safety_questions/update' => :update
      end

      resources :binding_emails, only: [:index, :show, :create]
      resources :favorites, only: [:index, :destroy]
      resources :addresses
      resources :orders, only: [:index]
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

  controller 'frontend/users/password_by_emails' do
    get 'users/passwords/email/new' => :new
    post 'users/passwords/email/create' => :create
  end

  controller 'frontend/users/questions' do
    get 'users/questions/new' => :new
    post 'users/questions/create' => :create
    get 'users/questions/edit' => :edit
    patch 'users/questions/update' => :update
  end

  #省市级联
  mount ChinaCity::Engine => '/china_city'

  scope :admin, module: :backend, as: :admin do
    concerns :authenticatable

    resources :users

    resources :products do
      resources :images
      resources :variants
      resources :product_variants, controller: 'variants'
      resources :product_properties, only: [:index]
    end
    resources :diamonds

    resources :properties
    resources :product_properties, controller: 'properties'

    resources :prototypes
    resources :product_prototypes, controller: 'prototypes'

    resources :option_types
    resources :product_option_types, controller: 'option_types'

    resources :taxonomies do
      resources :taxons, shallow: true
    end
    resources :taxonomy_taxons, controller: 'taxons'

    resources :promotions
    resources :promotion_categories
    resources :promotion_promotion_categories, controller: 'promotion_categories'
    resources :orders, only: [:index, :show]

    resources :comments do
      resources :replies, only: [:new, :create, :edit, :update]
    end
  end

  # Admin root path
  get 'admin', to: 'backend/dashboards#index'

  # You can have the root of your site routed with "root"
  root 'frontend/welcome#index'
end
