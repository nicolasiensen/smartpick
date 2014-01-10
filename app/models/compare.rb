class Compare < ActiveRecord::Base
  has_and_belongs_to_many :cars
  validate :presence_of_cars

  def presence_of_cars
    errors[:base] << "Escolha pelo menos um carro para comparar" if self.cars.empty?
  end

  def as_json options
    super({include: {cars: {include: :models}}}.merge(options))
  end
end
