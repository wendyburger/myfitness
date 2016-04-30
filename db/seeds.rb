# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

categories = ['胸肌','背肌', '肩膀', '手臂', '股四頭肌和小腿肌', '臀肌和腿後肌', '核心肌', '全身訓練', '有氧運動']

categories.each do |muscle|
  Category.create(name: muscle)
end
