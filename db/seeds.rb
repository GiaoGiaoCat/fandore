# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(email: 'wjp2013@gmail.com', mobile: '13269259377', password: '111111')

property_1 = Product::Property.create(name: 'Color', presentation: '颜色', category: 1)
property_2 = Product::Property.create(name: 'Size', presentation: '大小', category: 1)

option_type = Product::OptionType.create(name: 'Width', presentation: '体重')
Product::OptionValue.create(name: 'X', presentation: 'X', option_type_id: option_type.id)
Product::OptionValue.create(name: 'L', presentation: 'L', option_type_id: option_type.id)

prototype = Product::Prototype.create(name: '包包')

prototype.properties << [property_1, property_2]
prototype.option_types << option_type
