class Compare < ActiveRecord::Base
  has_and_belongs_to_many :cars
  validate :presence_of_cars

  def presence_of_cars
    errors[:base] << "A comparação precisa de pelo menos um modelo de carro" if self.cars.empty?
  end
end
