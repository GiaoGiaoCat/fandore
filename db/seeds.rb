# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

User.create(email: 'wjp2013@gmail.com', mobile: '13269259377', password: 'db5566')

# 戒托属性
# metal 材质
# style 款式
# center stone 主钻大小
# size 指圈范围
# sub stone style 副石款式
# sub stone weight 副石重量
# sub stone color 副钻类型
# sub stone quantity 副石数量

property_1 = Product::Property.create(name: 'Min Center Stone', presentation: '最小主钻')
property_2 = Product::Property.create(name: 'Max Center Stone', presentation: '最大主钻')
property_3 = Product::Property.create(name: 'Size', presentation: '指圈范围')
property_4 = Product::Property.create(name: 'Sub Stone Style', presentation: '款式')
property_5 = Product::Property.create(name: 'Sub Stone Weight', presentation: '副钻重量')
property_6 = Product::Property.create(name: 'Sub Stone Color', presentation: '副钻类型')
property_7 = Product::Property.create(name: 'Sub Stone Quantity', presentation: '副钻数量')

option_type_1 = Product::OptionType.create(name: 'Metal', presentation: '材质')
Product::OptionValue.create(name: '18K', presentation: '18K 白金', option_type_id: option_type_1.id)
Product::OptionValue.create(name: 'PT950', presentation: 'PT950', option_type_id: option_type_1.id)

option_type_2 = Product::OptionType.create(name: 'Style', presentation: '款式')
Product::OptionValue.create(name: 'Simple', presentation: '简约款', option_type_id: option_type_2.id)
Product::OptionValue.create(name: 'Luxury', presentation: '轻奢款', option_type_id: option_type_2.id)
Product::OptionValue.create(name: 'Custom', presentation: '高级订制款', option_type_id: option_type_2.id)

prototype_1 = Product::Prototype.create(name: '戒托')

prototype_1.properties << [property_1, property_2, property_3, property_4, property_5, property_6, property_7]
prototype_1.option_types << [option_type_1, option_type_2]

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

property_01 = Product::Property.create(name: 'Shape', presentation: '形状')
property_02 = Product::Property.create(name: 'Weight', presentation: '重量')
property_03 = Product::Property.create(name: 'Color', presentation: '颜色')
property_04 = Product::Property.create(name: 'Stock', presentation: '库存地址')
property_05 = Product::Property.create(name: 'Certificate Number', presentation: '证书编号')
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


prototype_2 = Product::Prototype.create(name: '钻石')

prototype_2.properties << [
  property_01, property_02, property_03, property_04, property_05, property_06, property_07,
  property_08, property_09, property_10, property_11, property_12, property_13, property_14,
  property_15, property_16, property_17, property_18
]
