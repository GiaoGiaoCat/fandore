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

  # You can have the root of your site routed with "root"
  root 'welcome#index'

end
