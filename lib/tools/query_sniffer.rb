# encoding: utf-8

module Tools
  class QuerySniffer
    GIA_URL = 'http://www.gia.edu/otmm_wcs_int/proxy-report/'.freeze

    class << self
      # Tools::QuerySniffer.get_gia_info(6222032974)
      def get_gia_info(report_number)
        uri = GIA_URL + "?ReportNumber=#{report_number}&url=https://myapps.gia.edu/ReportCheckPOC/pocservlet?ReportNumber=#{report_number}"
        xml = open(uri).read
        doc = Nokogiri::HTML(xml)
        result = {}
        doc.css("report_dtl").children.each do |ele|
          result[ele.name] = ele.children.text
        end
        result
      end

      # Tools::QuerySniffer.get_hca_info("60", "57", "34", "40.5", "0")
      def get_hca_info(depth_textbox, table_textbox, crown_textbox, pavilion_textbox, cutlet_textbox)
        uri = URI('http://www.pricescope.com/tools/hca')
        params = {
          depth_textbox: depth_textbox,
          table_textbox: table_textbox,
          crown_textbox: crown_textbox,
          pavilion_textbox: pavilion_textbox,
          cutlet_textbox: cutlet_textbox,
          crown_listbox: "0",
          pavilion_listbox: "0"
        }
        res = Net::HTTP.post_form(uri, params)
        html = res.body
        doc = Nokogiri::HTML(html)
        result = doc.css("table td font").children.map do |ele|
            ele.text
        end
        image = ""
        doc.css("table td img").each do |ele|
          image = ele.values[2]
        end
        result = result[16..26]
        result.delete_at(7)
        image_hash = {"image_path" => "http://www.pricescope.com" + image}
        Hash[*result].merge! image_hash
      end
    end

  end
end