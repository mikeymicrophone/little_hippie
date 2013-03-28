FactoryGirl.define do
  factory :customer do
    sequence(:email) { Faker::Internet.email }
    password 'password'
    password_confirmation 'password'
  end

  factory :shipping_address do
    sequence(:street) { |n| "#{n} 8th Avenue" }
  end

  factory :cart do
    trait :with_customer do
      customer FactoryGirl.create :customer
    end
    
    trait :with_shipping_address do
      shipping_address FactoryGirl.create :shipping_address
    end
  end  

  factory :color do
    name { Faker::Lorem.word }
    code { ('AA'..'ZZ').to_a.sample }
    css_hex_code { (0x100..0xfff).to_a.sample.to_s(16) }
  end
  
  factory :design do
    name { Faker::Lorem.word }
    number { (1..1000).to_a.sample }
  end
  
  factory :body_style do
    name { Faker::Lorem.word }
    code { ('AAA'...'ZZZ').to_a.sample }
    base_price { (1300..9999).to_a.sample }
  end

  factory :product do
    design FactoryGirl.create :design
    body_style FactoryGirl.create :body_style
    active true
  end

  factory :product_color do
    product FactoryGirl.create :product
    color FactoryGirl.create :color
  end

  factory :size do
    name { Faker::Lorem.word }
    code { ('AA'..'ZZ').to_a.sample }
  end
  
  factory :item do
    cart FactoryGirl.create :cart
    product_color FactoryGirl.create :product_color
    size FactoryGirl.create :size
  end  
end

FactoryGirl.modify do
  factory :cart do 
    trait :with_item do
      items FactoryGirl.create_list(:item, 2)
    end
  end
end
