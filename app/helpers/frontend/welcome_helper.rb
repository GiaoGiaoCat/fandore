module Frontend::WelcomeHelper
  def service_name(path)
    case path
    when '/service_2' then '7天无理由退货';
    when '/service_3' then '30天免费换货';
    when '/service_4' then 'GIA国际权威认证';
    when '/service_5' then '全额保价配送';
    else '购买须知'
    end
  end
end
