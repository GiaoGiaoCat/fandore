class Frontend::Tools::QuerySniffersController < Frontend::ApplicationController
  skip_before_action :authenticate_user!
  
  def gia_certificate
  end

  def gia_certificate_result
    @gia_infos = ::Tools::QuerySniffer.get_gia_info(params[:gia_number])
  end

end
