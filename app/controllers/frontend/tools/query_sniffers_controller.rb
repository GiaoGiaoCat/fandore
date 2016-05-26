class Frontend::Tools::QuerySniffersController < Frontend::ApplicationController
  skip_before_action :authenticate_user!
  
  def gia_certificate
    @gia_infos = ::Tools::QuerySniffer.get_gia_info(params[:gia_number])
  end

  def hca_query
    if request.method == "POST"
      @hac_results = ::Tools::QuerySniffer.get_hca_info(params[:depth_textbox], 
                                                      params[:table_textbox], params[:crown_textbox], 
                                                      params[:pavilion_textbox], params[:cutlet_textbox])
    end
  end

end
