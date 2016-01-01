class Frontend::Users::AddressesController < Frontend::ApplicationController

  def index
    load_addresses
    build_address
  end

  def new
    build_address
  end

  def create
    build_address
    save_address
  end

  def edit
    load_address
    build_address
    respond_to do |format|
      format.html { render layout: false }
      format.js
    end
  end

  def update
    load_address
    build_address
    save_address
  end

  def destroy
    load_address
    @address.destroy
  end

  private

  def load_user
    @user = current_user
  end

  def load_addresses
    @addresses ||= address_scope.all
  end

  def load_address
    @address ||= address_scope.find(params[:id])
  end

  def build_address
    @address ||= address_scope.new
    @address.attributes = address_params
  end

  def save_address
    @address.save
  end

  def address_params
    address_params = params[:user_address]
    address_params ? address_params.permit! : {}
  end

  def address_scope
    current_user.addresses
  end

end
