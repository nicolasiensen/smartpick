class Brand < ActiveRecord::Base
  validates :name, :uid, presence: true
  validates :uid, uniqueness: true
  has_many :cars
end
