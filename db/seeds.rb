# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

admin = User.create(email: 'wjp2013@gmail.com', mobile: '13269259377', password: 'db5566', role: "admin")
member = User.create(email: 'lishaohua2013@gmail.com', mobile: '13269259372', password: 'db5566', role: "member")
User.create(email: 'li2013@gmail.com', mobile: '13269259371', password: 'db5566', role: "customer_service")
User.create(email: 'ls2013@gmail.com', mobile: '13269259370', password: 'db5566', role: "product_manager")
address = User::Address.create(user_id: member.id, province:"120000", zipcode:"120100", city: "120100", district: "120102", name: "lishaohua", mobile: "13932011432", is_default: true, address: "长安大街101号楼1202")

# 支付方式

Payment::PaymentMethod.create(name: 'alipay', description: '支付宝支付', type: 'Payment::Alipay')
Payment::PaymentMethod.create(name: 'wxpay', description: '微信支付', type: 'Payment::Wxpay')
Payment::PaymentMethod.create(name: 'bankpay', description: '支付宝网银支付', type: 'Payment::Bankpay')

# 戒托属性和可选属性
# metal 材质（可选）
# style 款式（可选）
# center stone 主钻大小
# size 指圈范围
# sub stone style 副石款式
# sub stone weight 副石重量
# sub stone color 副钻类型
# sub stone quantity 副石数量

property_001 = Product::Property.create(name: 'Min Center Stone', presentation: '最小主钻')
property_002 = Product::Property.create(name: 'Max Center Stone', presentation: '最大主钻')
property_003 = Product::Property.create(name: 'Size', presentation: '指圈范围')
property_013 = Product::Property.create(name: 'Male Size', presentation: '男款指圈范围')
property_023 = Product::Property.create(name: 'Female Size', presentation: '女款指圈范围')
property_004 = Product::Property.create(name: 'Sub Stone Style', presentation: '副钻款式')
property_005 = Product::Property.create(name: 'Sub Stone Weight', presentation: '副钻重量')
property_006 = Product::Property.create(name: 'Sub Stone Color', presentation: '副钻类型')
property_007 = Product::Property.create(name: 'Sub Stone Quantity', presentation: '副钻数量')

option_type_1 = Product::OptionType.create(name: 'Metal', presentation: '材质', position: 0)
Product::OptionValue.create(name: '18K', presentation: '18K 白金', option_type_id: option_type_1.id)
Product::OptionValue.create(name: 'PT950', presentation: 'PT950', option_type_id: option_type_1.id)

option_type_2 = Product::OptionType.create(name: 'Style', presentation: '款式', position: 1)
Product::OptionValue.create(name: 'Simple', presentation: '简约款', option_type_id: option_type_2.id)
Product::OptionValue.create(name: 'Luxury', presentation: '轻奢款', option_type_id: option_type_2.id)
Product::OptionValue.create(name: 'Custom', presentation: '高级订制款', option_type_id: option_type_2.id)

prototype_1 = Product::Prototype.create(name: '戒托')
prototype_1.properties << [property_001, property_002, property_003, property_004, property_005, property_006, property_007]
prototype_1.option_types << [option_type_1, option_type_2]

option_type_3 = Product::OptionType.create(name: 'Style', presentation: '款式', position: 3)
Product::OptionValue.create(name: 'Couples', presentation: '男女对戒', option_type_id: option_type_3.id)
Product::OptionValue.create(name: 'Male', presentation: '单男款', option_type_id: option_type_3.id)
Product::OptionValue.create(name: 'Female', presentation: '单女款', option_type_id: option_type_3.id)

prototype_02 = Product::Prototype.create(name: '对戒')
prototype_02.option_types << [option_type_1, option_type_3]
# 钻石属性
# shape 形状
# weight 重量
# color 颜色
# stock 库存地址
# certificate number 证书编号
# certificate 证书类型
# culet 底尖
# girdle thickness 腰围厚度
# depth ratio 深度比
# table ratio 台面比
# min measurement 最小直径
# max measurement 最大直径
# depth 深度
# fluorescence 荧光反应
# polish 抛光
# cut 切工
# symmetry 对称性
# clarity 净度
# Lettering 刻字
# Certificate No 钻石证书编号

property_01 = Product::Property.create(name: 'Shape', presentation: '形状')
property_02 = Product::Property.create(name: 'Weight', presentation: '重量')
property_03 = Product::Property.create(name: 'Color', presentation: '颜色')
property_04 = Product::Property.create(name: 'Stock', presentation: '库存地址')
property_05 = Product::Property.create(name: 'GIA Report Number', presentation: '证书编号')
property_06 = Product::Property.create(name: 'Certificate', presentation: '证书类型')
property_07 = Product::Property.create(name: 'Culet', presentation: '底尖')
property_08 = Product::Property.create(name: 'Girdle Thickness', presentation: '腰围厚度')
property_09 = Product::Property.create(name: 'Depth Ratio', presentation: '深度比')
property_10 = Product::Property.create(name: 'Table Ratio', presentation: '台面比')
property_11 = Product::Property.create(name: 'Min Measurement', presentation: '最小直径')
property_12 = Product::Property.create(name: 'Max Measurement', presentation: '最大直径')
property_13 = Product::Property.create(name: 'Depth', presentation: '深度')
property_14 = Product::Property.create(name: 'Fluorescence', presentation: '荧光反应')
property_15 = Product::Property.create(name: 'Polish', presentation: '抛光')
property_16 = Product::Property.create(name: 'Cut', presentation: '切工')
property_17 = Product::Property.create(name: 'Symmetry', presentation: '对称性')
property_18 = Product::Property.create(name: 'Clarity', presentation: '净度')
property_20 = Product::Property.create(name: 'Certificate No', presentation: '钻石证书编号')
property_19 = Product::Property.create(name: 'Lettering', presentation: '刻字内容')
property_21 = Product::Property.create(name: 'Male Lettering', presentation: '男款刻字内容')
property_22 = Product::Property.create(name: 'Female Lettering', presentation: '女款刻字内容')


prototype_2 = Product::Prototype.create(name: '钻石')

prototype_2.properties << [
  property_01, property_02, property_03, property_04, property_05, property_06, property_07,
  property_08, property_09, property_10, property_11, property_12, property_13, property_14,
  property_15, property_16, property_17, property_18
]

prototype_3 = Product::Prototype.create(name: '求婚钻戒订单项')
prototype_3.properties << [property_003, property_19]

prototype_3 = Product::Prototype.create(name: '钻石订单项')
prototype_3.properties << [property_20]

prototype_3 = Product::Prototype.create(name: '结婚对戒订单项')
prototype_3.properties << [property_013, property_023, property_21, property_22]

# 分类
taxon_1 = Taxonomy.create(name: '求婚钻戒')
taxon_2 = Taxonomy.create(name: '钻石')
taxon_3 = Taxonomy.create(name: '结婚对戒')
Taxonomy.create(name: '饰品')
Taxonomy.create(name: '周边礼品')

# 添加默认钻石模板
# 第一组
product_011 = Product.new(name: '0.3Ct-D-IF', prototype_id: prototype_2.id, taxon_ids: taxon_2.id)
product_011.price = 12900
product_011.save
product_011.product_properties.find_by(property_id: property_02.id).update(value: '0.3Ct')
product_011.product_properties.find_by(property_id: property_03.id).update(value: 'D')
product_011.product_properties.find_by(property_id: property_18.id).update(value: 'IF')

product_012 = Product.new(name: '0.3Ct-E-IF', prototype_id: prototype_2.id, taxon_ids: taxon_2.id)
product_012.price = 9880
product_012.save
product_012.product_properties.find_by(property_id: property_02.id).update(value: '0.3Ct')
product_012.product_properties.find_by(property_id: property_03.id).update(value: 'E')
product_012.product_properties.find_by(property_id: property_18.id).update(value: 'IF')

product_013 = Product.new(name: '0.3Ct-F-IF', prototype_id: prototype_2.id, taxon_ids: taxon_2.id)
product_013.price = 8789
product_013.save
product_013.product_properties.find_by(property_id: property_02.id).update(value: '0.3Ct')
product_013.product_properties.find_by(property_id: property_03.id).update(value: 'F')
product_013.product_properties.find_by(property_id: property_18.id).update(value: 'IF')

product_021 = Product.new(name: '0.3Ct-D-VVS1', prototype_id: prototype_2.id, taxon_ids: taxon_2.id)
product_021.price = 9660
product_021.save
product_021.product_properties.find_by(property_id: property_02.id).update(value: '0.3Ct')
product_021.product_properties.find_by(property_id: property_03.id).update(value: 'D')
product_021.product_properties.find_by(property_id: property_18.id).update(value: 'VVS1')

product_022 = Product.new(name: '0.3Ct-E-VVS1', prototype_id: prototype_2.id, taxon_ids: taxon_2.id)
product_022.price = 8890
product_022.save
product_022.product_properties.find_by(property_id: property_02.id).update(value: '0.3Ct')
product_022.product_properties.find_by(property_id: property_03.id).update(value: 'E')
product_022.product_properties.find_by(property_id: property_18.id).update(value: 'VVS1')

product_023 = Product.new(name: '0.3Ct-F-VVS1', prototype_id: prototype_2.id, taxon_ids: taxon_2.id)
product_023.price = 8670
product_023.save
product_023.product_properties.find_by(property_id: property_02.id).update(value: '0.3Ct')
product_023.product_properties.find_by(property_id: property_03.id).update(value: 'F')
product_023.product_properties.find_by(property_id: property_18.id).update(value: 'VVS1')

product_031 = Product.new(name: '0.3Ct-D-VVS2', prototype_id: prototype_2.id, taxon_ids: taxon_2.id)
product_031.price = 8780
product_031.save
product_031.product_properties.find_by(property_id: property_02.id).update(value: '0.3Ct')
product_031.product_properties.find_by(property_id: property_03.id).update(value: 'D')
product_031.product_properties.find_by(property_id: property_18.id).update(value: 'VVS2')

product_032 = Product.new(name: '0.3Ct-E-VVS2', prototype_id: prototype_2.id, taxon_ids: taxon_2.id)
product_032.price = 8670
product_032.save
product_032.product_properties.find_by(property_id: property_02.id).update(value: '0.3Ct')
product_032.product_properties.find_by(property_id: property_03.id).update(value: 'E')
product_032.product_properties.find_by(property_id: property_18.id).update(value: 'VVS2')

product_033 = Product.new(name: '0.3Ct-F-VVS2', prototype_id: prototype_2.id, taxon_ids: taxon_2.id)
product_033.price = 8060
product_033.save
product_033.product_properties.find_by(property_id: property_02.id).update(value: '0.3Ct')
product_033.product_properties.find_by(property_id: property_03.id).update(value: 'F')
product_033.product_properties.find_by(property_id: property_18.id).update(value: 'VVS2')
# 第二组
product_111 = Product.new(name: '0.5Ct-D-IF', prototype_id: prototype_2.id, taxon_ids: taxon_2.id)
product_111.price = 40160
product_111.save
product_111.product_properties.find_by(property_id: property_02.id).update(value: '0.5Ct')
product_111.product_properties.find_by(property_id: property_03.id).update(value: 'D')
product_111.product_properties.find_by(property_id: property_18.id).update(value: 'IF')

product_112 = Product.new(name: '0.5Ct-E-IF', prototype_id: prototype_2.id, taxon_ids: taxon_2.id)
product_112.price = 29800
product_112.save
product_112.product_properties.find_by(property_id: property_02.id).update(value: '0.5Ct')
product_112.product_properties.find_by(property_id: property_03.id).update(value: 'E')
product_112.product_properties.find_by(property_id: property_18.id).update(value: 'IF')

product_113 = Product.new(name: '0.5Ct-F-IF', prototype_id: prototype_2.id, taxon_ids: taxon_2.id)
product_113.price = 26600
product_113.save
product_113.product_properties.find_by(property_id: property_02.id).update(value: '0.5Ct')
product_113.product_properties.find_by(property_id: property_03.id).update(value: 'F')
product_113.product_properties.find_by(property_id: property_18.id).update(value: 'IF')

product_121 = Product.new(name: '0.5Ct-D-VVS1', prototype_id: prototype_2.id, taxon_ids: taxon_2.id)
product_121.price = 29500
product_121.save
product_121.product_properties.find_by(property_id: property_02.id).update(value: '0.5Ct')
product_121.product_properties.find_by(property_id: property_03.id).update(value: 'D')
product_121.product_properties.find_by(property_id: property_18.id).update(value: 'VVS1')

product_122 = Product.new(name: '0.5Ct-E-VVS1', prototype_id: prototype_2.id, taxon_ids: taxon_2.id)
product_122.price = 25200
product_122.save
product_122.product_properties.find_by(property_id: property_02.id).update(value: '0.5Ct')
product_122.product_properties.find_by(property_id: property_03.id).update(value: 'E')
product_122.product_properties.find_by(property_id: property_18.id).update(value: 'VVS1')

product_123 = Product.new(name: '0.5Ct-F-VVS1', prototype_id: prototype_2.id, taxon_ids: taxon_2.id)
product_123.price = 23500
product_123.save
product_123.product_properties.find_by(property_id: property_02.id).update(value: '0.5Ct')
product_123.product_properties.find_by(property_id: property_03.id).update(value: 'F')
product_123.product_properties.find_by(property_id: property_18.id).update(value: 'VVS1')

product_131 = Product.new(name: '0.5Ct-D-VVS2', prototype_id: prototype_2.id, taxon_ids: taxon_2.id)
product_131.price = 25000
product_131.save
product_131.product_properties.find_by(property_id: property_02.id).update(value: '0.5Ct')
product_131.product_properties.find_by(property_id: property_03.id).update(value: 'D')
product_131.product_properties.find_by(property_id: property_18.id).update(value: 'VVS2')

product_132 = Product.new(name: '0.5Ct-E-VVS2', prototype_id: prototype_2.id, taxon_ids: taxon_2.id)
product_132.price = 21380
product_132.save
product_132.product_properties.find_by(property_id: property_02.id).update(value: '0.5Ct')
product_132.product_properties.find_by(property_id: property_03.id).update(value: 'E')
product_132.product_properties.find_by(property_id: property_18.id).update(value: 'VVS2')

product_133 = Product.new(name: '0.5Ct-F-VVS2', prototype_id: prototype_2.id, taxon_ids: taxon_2.id)
product_133.price = 20480
product_133.save
product_133.product_properties.find_by(property_id: property_02.id).update(value: '0.5Ct')
product_133.product_properties.find_by(property_id: property_03.id).update(value: 'F')
product_133.product_properties.find_by(property_id: property_18.id).update(value: 'VVS2')
# 第三组
product_211 = Product.new(name: '1Ct-D-IF', prototype_id: prototype_2.id, taxon_ids: taxon_2.id)
product_211.price = 168600
product_211.save
product_211.product_properties.find_by(property_id: property_02.id).update(value: '1Ct')
product_211.product_properties.find_by(property_id: property_03.id).update(value: 'D')
product_211.product_properties.find_by(property_id: property_18.id).update(value: 'IF')

product_212 = Product.new(name: '1Ct-E-IF', prototype_id: prototype_2.id, taxon_ids: taxon_2.id)
product_212.price = 119800
product_212.save
product_212.product_properties.find_by(property_id: property_02.id).update(value: '1Ct')
product_212.product_properties.find_by(property_id: property_03.id).update(value: 'E')
product_212.product_properties.find_by(property_id: property_18.id).update(value: 'IF')

product_213 = Product.new(name: '1Ct-F-IF', prototype_id: prototype_2.id, taxon_ids: taxon_2.id)
product_213.price = 9800
product_213.save
product_213.product_properties.find_by(property_id: property_02.id).update(value: '1Ct')
product_213.product_properties.find_by(property_id: property_03.id).update(value: 'F')
product_213.product_properties.find_by(property_id: property_18.id).update(value: 'IF')

product_221 = Product.new(name: '1Ct-D-VVS1', prototype_id: prototype_2.id, taxon_ids: taxon_2.id)
product_221.price = 139500
product_221.save
product_221.product_properties.find_by(property_id: property_02.id).update(value: '1Ct')
product_221.product_properties.find_by(property_id: property_03.id).update(value: 'D')
product_221.product_properties.find_by(property_id: property_18.id).update(value: 'VVS1')

product_222 = Product.new(name: '1Ct-E-VVS1', prototype_id: prototype_2.id, taxon_ids: taxon_2.id)
product_222.price = 115000
product_222.save
product_222.product_properties.find_by(property_id: property_02.id).update(value: '1Ct')
product_222.product_properties.find_by(property_id: property_03.id).update(value: 'E')
product_222.product_properties.find_by(property_id: property_18.id).update(value: 'VVS1')

product_223 = Product.new(name: '1Ct-F-VVS1', prototype_id: prototype_2.id, taxon_ids: taxon_2.id)
product_223.price = 97000
product_223.save
product_223.product_properties.find_by(property_id: property_02.id).update(value: '1Ct')
product_223.product_properties.find_by(property_id: property_03.id).update(value: 'F')
product_223.product_properties.find_by(property_id: property_18.id).update(value: 'VVS1')

product_231 = Product.new(name: '1Ct-D-VVS2', prototype_id: prototype_2.id, taxon_ids: taxon_2.id)
product_231.price = 116200
product_231.save
product_231.product_properties.find_by(property_id: property_02.id).update(value: '1Ct')
product_231.product_properties.find_by(property_id: property_03.id).update(value: 'D')
product_231.product_properties.find_by(property_id: property_18.id).update(value: 'VVS2')

product_232 = Product.new(name: '1Ct-E-VVS2', prototype_id: prototype_2.id, taxon_ids: taxon_2.id)
product_232.price = 98700
product_232.save
product_232.product_properties.find_by(property_id: property_02.id).update(value: '1Ct')
product_232.product_properties.find_by(property_id: property_03.id).update(value: 'E')
product_232.product_properties.find_by(property_id: property_18.id).update(value: 'VVS2')

product_233 = Product.new(name: '1Ct-F-VVS2', prototype_id: prototype_2.id, taxon_ids: taxon_2.id)
product_233.price = 88000
product_233.save
product_233.product_properties.find_by(property_id: property_02.id).update(value: '1Ct')
product_233.product_properties.find_by(property_id: property_03.id).update(value: 'F')
product_233.product_properties.find_by(property_id: property_18.id).update(value: 'VVS2')
# 添加默认图片
# default_image = Image.new
# default_image.picture = Rails.root.join("public/self_name.png").open
# default_image.save


# 添加默认戒托模板
product_01 = Product.new(name: 'Roseland', prototype_id: prototype_1.id, taxon_ids: taxon_1.id)
product_01.price = 2500
product_01.status = 'available'
product_01.description = '用心才能真正看得清。你的美丽与善良，众所周知，但你的特别，只有我才知道，因为你是我的玫瑰。庄园里有很多叫rose的花，对我而言，你才是最重要的，经得起终身承诺，一生陪伴。'
product_01.save
v1 = product_01.variants.new(option_value_ids: ["1", "3"], price: 2500) # 18K金 简约款
v1.save
v2 = product_01.variants.new(option_value_ids: ["1", "4"], price: 2500) # 18K金 轻奢款
v2.save
master = product_01.master
img_1 = Image.new(viewable_id: master.id, viewable_type: 'Product::Variant')
img_1.picture = File.new(Rails.root.join('db', 'images', 'roseland', 'pic1.png'))
img_1.save
img_2 = Image.new(viewable_id: master.id, viewable_type: 'Product::Variant')
img_2.picture = File.new(Rails.root.join('db', 'images', 'roseland', 'pic2.png'))
img_2.save

product_02 = Product.new(name: '微澜', prototype_id: prototype_1.id, taxon_ids: taxon_1.id)
product_02.price = 3000
product_02.status = 'available'
product_02.description = '总有些意想不到的惊喜，不刻意为之，怦然于心。相遇的瞬间就已触动，窃窃的喜悦弥漫心间，那一丝波澜，想要一辈子珍藏。因为你我，爱才存在，相濡以沫或归于平静，偶有的涟漪，希望如初见般甜蜜温暖。'
product_02.save
v1 = product_02.variants.new(option_value_ids: ["1", "3"], price: 3000) # 18K金 简约款
v1.save
v2 = product_02.variants.new(option_value_ids: ["1", "4"], price: 3000) # 18K金 轻奢款
v2.save
master = product_02.master
img_1 = Image.new(viewable_id: master.id, viewable_type: 'Product::Variant')
img_1.picture = File.new(Rails.root.join('db', 'images', 'whispper', 'pic1.png'))
img_1.save
img_2 = Image.new(viewable_id: master.id, viewable_type: 'Product::Variant')
img_2.picture = File.new(Rails.root.join('db', 'images', 'whispper', 'pic2.png'))
img_2.save

product_03 = Product.new(name: '简爱', prototype_id: prototype_1.id, taxon_ids: taxon_1.id)
product_03.price = 2000
product_03.status = 'available'
product_03.description = '轻简是一种姿态，不凡的爱情正在延绵。说不上为什么，我变得很主动，这很真实，你就是我要找的。褪去繁复，淬炼菁华，心意凝然于指，爱意久远于心，简单却是最完整。'
product_03.save
v1 = product_03.variants.new(option_value_ids: ["1", "3"], price: 2000) # 18K金 简约款
v1.save
v2 = product_03.variants.new(option_value_ids: ["1", "4"], price: 2000) # 18K金 轻奢款
v2.save
master = product_03.master
img_1 = Image.new(viewable_id: master.id, viewable_type: 'Product::Variant')
img_1.picture = File.new(Rails.root.join('db', 'images', 'jianai', 'pic1.png'))
img_1.save
img_2 = Image.new(viewable_id: master.id, viewable_type: 'Product::Variant')
img_2.picture = File.new(Rails.root.join('db', 'images', 'jianai', 'pic2.png'))
img_2.save

product_04 = Product.new(name: '花冠', prototype_id: prototype_1.id, taxon_ids: taxon_1.id)
product_04.price = 2500
product_04.status = 'available'
product_04.description = '从触目可及的美好中给予最好的只是一个开始。你以一朵花的姿态自由行走，惊艳了时光，惹醉了岁月，悠然入我心。那不染尘俗的美，在我心间静静绽放，凝固成最永恒的爱恋。'
product_04.save
v01 = product_04.variants.new(option_value_ids: ["1", "3"], price: 2500) # 18K金 简约款
v01.save
v02 = product_04.variants.new(option_value_ids: ["1", "4"], price: 2500) # 18K金 轻奢款
v02.save
master = product_04.master
img_1 = Image.new(viewable_id: master.id, viewable_type: 'Product::Variant')
img_1.picture = File.new(Rails.root.join('db', 'images', 'thecrown', 'pic1.png'))
img_1.save
img_2 = Image.new(viewable_id: master.id, viewable_type: 'Product::Variant')
img_2.picture = File.new(Rails.root.join('db', 'images', 'thecrown', 'pic2.png'))
img_2.save

# 对戒
product_05 = Product.new(name: '微澜对戒', prototype_id: prototype_02.id, taxon_ids: taxon_3.id)
product_05.price = 3000
product_05.status = 'available'
product_05.description = '总有些意想不到的惊喜，不刻意为之，怦然于心。相遇的瞬间就已触动，窃窃的喜悦弥漫心间，那一丝波澜，想要一辈子珍藏。因为你我，爱才存在，相濡以沫或归于平静，偶有的涟漪，希望如初见般甜蜜温暖。'
product_05.save

v1 = product_05.variants.new(option_value_ids: ["1", "6"], price: 13000, sku: '18K-MF') # 18K金 男女
v1.save
v2 = product_05.variants.new(option_value_ids: ["1", "7"], price: 6000, sku: '18K-M') # 18K金 男
v2.save
v1 = product_05.variants.new(option_value_ids: ["1", "8"], price: 7000, sku: '18K-F') # 18K金 女
v1.save
v2 = product_05.variants.new(option_value_ids: ["2", "6"], price: 12000, sku: 'PT950-MF') # PT950 男女
v2.save
v1 = product_05.variants.new(option_value_ids: ["2", "7"], price: 5500, sku: 'PT950-M') # PT950 男
v1.save
v2 = product_05.variants.new(option_value_ids: ["2", "8"], price: 6500, sku: 'PT950-F') # PT950 女
v2.save
master = product_05.master
img_1 = Image.new(viewable_id: master.id, viewable_type: 'Product::Variant')
img_1.picture = File.new(Rails.root.join('db', 'images', 'whispper', 'pic1.png'))
img_1.save
img_2 = Image.new(viewable_id: master.id, viewable_type: 'Product::Variant')
img_2.picture = File.new(Rails.root.join('db', 'images', 'whispper', 'pic2.png'))
img_2.save


# 添加求婚戒指订单
order = Order.new(user: member)
line_item_1 = Order::LineItem.create(variant: v01, quantity: 1)
item_size = Product::Property.find_by(name: 'Size')
item_lettering = Product::Property.find_by(name: 'Lettering')
line_item_1.line_items_properties.find_by(property_id: item_size.id).update(value: '7')
line_item_1.line_items_properties.find_by(property_id: item_lettering.id).update(value: 'Love')

line_item_2 = Order::LineItem.create(variant: product_122.master, quantity: 1)
line_item_2.parent_id = line_item_1.id

order.line_items << line_item_1
order.line_items << line_item_2

order.shipping_address = address
order.state = "checkout"
order.save

# 添加已完成的订单，测试评论
order = Order.new(user: member)
line_item_1 = Order::LineItem.create(variant: v01, quantity: 1)
item_size = Product::Property.find_by(name: 'Size')
item_lettering = Product::Property.find_by(name: 'Lettering')
line_item_1.line_items_properties.find_by(property_id: item_size.id).update(value: '7')
line_item_1.line_items_properties.find_by(property_id: item_lettering.id).update(value: 'Love')

line_item_2 = Order::LineItem.create(variant: product_122.master, quantity: 1)
line_item_2.parent_id = line_item_1.id

order.line_items << line_item_1
order.line_items << line_item_2

order.shipping_address = address
order.state = "completed"
order.save

# 添加已发货的订单，测试签收
order = Order.new(user: member)
line_item_1 = Order::LineItem.create(variant: v01, quantity: 1)
item_size = Product::Property.find_by(name: 'Size')
item_lettering = Product::Property.find_by(name: 'Lettering')
line_item_1.line_items_properties.find_by(property_id: item_size.id).update(value: '7')
line_item_1.line_items_properties.find_by(property_id: item_lettering.id).update(value: 'Love')

line_item_2 = Order::LineItem.create(variant: product_122.master, quantity: 1)
line_item_2.parent_id = line_item_1.id

order.line_items << line_item_1
order.line_items << line_item_2

order.shipping_address = address
order.state = "delivered"
order.save


# 添加结婚对戒订单
order = Order.new(user: member)
line_item_1 = Order::LineItem.create(variant: v1, quantity: 1)
male_size = Product::Property.find_by(name: 'Male Size')
male_lettering = Product::Property.find_by(name: 'Male Lettering')
female_size = Product::Property.find_by(name: 'Female Size')
female_lettering = Product::Property.find_by(name: 'Female Lettering')
line_item_1.line_items_properties.find_by(property_id: male_size.id).update(value: '7')
line_item_1.line_items_properties.find_by(property_id: male_lettering.id).update(value: 'Boy')
line_item_1.line_items_properties.find_by(property_id: female_size.id).update(value: '5')
line_item_1.line_items_properties.find_by(property_id: female_lettering.id).update(value: 'Girl')
order.line_items << line_item_1
order.shipping_address = address
order.state = "checkout"
order.save
