require 'machinist/active_record'

Car.blueprint do
  name  { Faker::Name.name }
  brand
end

Brand.blueprint do
  name { Faker::Company.name }
end

Model.blueprint do
  name  { Faker::Number.number(4) }
  uid   { sn }
  car
end
