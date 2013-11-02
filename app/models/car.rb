class Car < ActiveRecord::Base
  validates :name, :brand_id, :uid, presence: true
  validates :uid, uniqueness: true
  belongs_to :brand
  has_many :models
end
