puts 'Clearing existing data...'

CombinationRuleValue.destroy_all
CombinationRule.destroy_all
ProductOptionValue.destroy_all
ProductOptionType.destroy_all
OptionValue.destroy_all
OptionType.destroy_all
Product.destroy_all

puts 'Creating products...'
basic_bike = Product.create!(name: 'Basic Bike', description: 'Just a standard bicycle', base_price: 100)
mountain_bike = Product.create!(name: 'Mountain Bike', description: 'An off-road bike with extra features', base_price: 250)

puts 'Creating option types + values...'
frame_type = OptionType.create!(name: 'Frame', description: 'Different frame styles')
full_susp  = OptionValue.create!(option_type: frame_type, name: 'Full-Suspension')
diamond    = OptionValue.create!(option_type: frame_type, name: 'Diamond')

finish_type = OptionType.create!(name: 'Finish', description: 'Paint finish options')
OptionValue.create!(option_type: finish_type, name: 'Matte')
shiny = OptionValue.create!(option_type: finish_type, name: 'Shiny')

wheel_type  = OptionType.create!(name: 'Wheels', description: 'Different wheel sets')
OptionValue.create!(option_type: wheel_type, name: 'Road Wheels')
OptionValue.create!(option_type: wheel_type, name: 'Mountain Wheels')

basket_type = OptionType.create!(name: 'Basket', description: 'Different types of baskets for the bike')
OptionValue.create!(option_type: basket_type, name: 'None')
OptionValue.create!(option_type: basket_type, name: 'Wood')
OptionValue.create!(option_type: basket_type, name: 'White')

puts 'Linking option types and values to products...'
[basic_bike, mountain_bike].each do |product|
  [frame_type, finish_type, wheel_type, basket_type].each do |type|
    next if type == basket_type && product != basic_bike # Only the basic bike has basket

    product_option_type = ProductOptionType.create!(product: product, option_type: type)
    type.option_values.each do |ov|
      availability_type = ProductOptionValue.availability_types.keys.sample
      ProductOptionValue.create!(
        product_option_type:,
        option_value: ov,
        availability_type:,
        stock: (rand(0..5) if availability_type == 'stock_controlled')
      )
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
