class Compare < ActiveRecord::Base
  has_and_belongs_to_many :models
  validate :presence_of_models

  def presence_of_models
    errors[:base] << "A comparação precisa de pelo menos um modelo de carro" if self.models.empty?
  end
end
