class Frontend::Users::AddressesController < Frontend::ApplicationController

  def index
    load_addresses
  end

  def new
    build_address
  end

  def create
    build_address
    save_address or render "new"
  end

  def edit
    load_address
    build_address
  end

  def update
    load_address
    @address.update(address_params)
    save_address or render "edit"
  end

  def destroy
    load_address
    @address.destroy
    redirect_to users_addresses_path
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
    @address ||= address_scope.build(address_params) 
  end

  def save_address
    if @address.save
      redirect_to root_path
    end
  end

  def address_params
    address_params = params[:user_address]
    address_params ? address_params.permit(:post_code, :full_name, :mobile, :address_detail, :province, 
                                            :district, :city, :phone_section, :phone_code, :phone_ext) : {}
  end

  def address_scope
    current_user.addresses
  end

end