# encoding: utf-8

module Tools
  class QuerySniffer

    class << self
      # Tools::QuerySniffer.get_gia_info(6222032974)
      def get_gia_info(report_number)
        uri = "http://www.gia.edu/otmm_wcs_int/proxy-report/?ReportNumber=#{report_number}&url=https://myapps.gia.edu/ReportCheckPOC/pocservlet?ReportNumber=#{report_number}"
        xml = open(uri).read
        doc = Nokogiri::HTML(xml)
        result = {}
        doc.css("report_dtl").children.each do |ele|
          result[ele.name] = ele.children.text
        end
        result
      end

      # Tools::QuerySniffer.get_hca_info
      def get_hca_info
        uri = URI('http://www.pricescope.com/tools/hca')
        params = {
          depth_textbox: 60,
          table_textbox: 57,
          crown_textbox: 34,
          cutlet_textbox: 0,
          pavilion_textbox: 40.5,
          crown_listbox: 0,
          pavilion_listbox: 0
        }
        res = Net::HTTP.post_form(uri, params)
        puts res.body
      end
    end

  end
end