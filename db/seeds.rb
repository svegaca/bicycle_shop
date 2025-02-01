puts 'Clearing existing data...'

CombinationRuleValue.destroy_all
CombinationRule.destroy_all
ProductOptionValue.destroy_all
ProductOptionType.destroy_all
OptionValue.destroy_all
OptionType.destroy_all
Product.destroy_all

puts 'Creating products...'
basic_bike = Product.create!(name: 'Basic Bike', description: 'Just a standard bicycle')
mountain_bike = Product.create!(name: 'Mountain Bike', description: 'An off-road bike with extra features')

puts 'Creating option types + values...'
frame_type = OptionType.create!(name: 'Frame', description: 'Different frame styles')
full_susp  = OptionValue.create!(option_type: frame_type, name: 'Full-Suspension', base_price: '349.99', availability_type: 'stock_controlled', stock: 5)
diamond    = OptionValue.create!(option_type: frame_type, name: 'Diamond', base_price: '299.99', availability_type: 'stock_controlled', stock: 6)
OptionValue.create!(option_type: frame_type, name: 'Carbon', base_price: '359.99', availability_type: 'stock_controlled', stock: 2)

finish_type = OptionType.create!(name: 'Finish', description: 'Paint finish options')
OptionValue.create!(option_type: finish_type, name: 'Matte', base_price: '27.50', availability_type: 'always_in_stock')
shiny = OptionValue.create!(option_type: finish_type, name: 'Shiny', base_price: '29', availability_type: 'always_in_stock')

wheel_type  = OptionType.create!(name: 'Wheels', description: 'Different wheel sets')
OptionValue.create!(option_type: wheel_type, name: 'Road Wheels', base_price: '72', availability_type: 'stock_controlled', stock: 4)
OptionValue.create!(option_type: wheel_type, name: 'Mountain Wheels', base_price: '89', availability_type: 'stock_controlled', stock: 3)

basket_type = OptionType.create!(name: 'Basket', description: 'Different types of baskets for the bike')
OptionValue.create!(option_type: basket_type, name: 'None', base_price: '0', availability_type: 'always_in_stock')
OptionValue.create!(option_type: basket_type, name: 'Wood', base_price: '19', availability_type: 'stock_controlled', stock: 2)
OptionValue.create!(option_type: basket_type, name: 'White', base_price: '15', availability_type: 'stock_controlled', stock: 8)

puts 'Linking option types and values to products...'
[basic_bike, mountain_bike].each do |product|
  [frame_type, finish_type, wheel_type, basket_type].each do |option_type|
    next if option_type == basket_type && product == mountain_bike # The mountain bike can not include a basket

    product_option_type = ProductOptionType.create!(product:, option_type:)
    option_type.option_values.each do |option_value|
      next if option_value == full_susp && product == basic_bike # The basic bike can not mount Full-Suspension frame

      ProductOptionValue.create!(product_option_type:, option_value:)
    end
  end
end

puts 'Creating combination rules...'

# 1) A forbidden combination rule for the Basic Bike
#    e.g., 'Diamond Frame + Shiny finish' is not possible on the basic bike.
forbidden_rule = ForbiddenCombinationRule.create!(
  product: basic_bike,
  description: 'Diamond + Shiny finish is forbidden on Basic Bike'
)
CombinationRuleValue.create!(combination_rule: forbidden_rule, option_value: diamond)
CombinationRuleValue.create!(combination_rule: forbidden_rule, option_value: shiny)

# 2) A price modifier rule for the Mountain Bike
#    e.g., 'Full-Suspension + Shiny finish' => +30 EUR
price_rule = PriceModifierCombinationRule.create!(
  product: mountain_bike,
  description: 'Full-susp + shiny => +30 EUR for paint coverage',
  modifier_amount: 30
)
CombinationRuleValue.create!(combination_rule: price_rule, option_value: full_susp)
CombinationRuleValue.create!(combination_rule: price_rule, option_value: shiny)

puts 'Seeding complete!'
