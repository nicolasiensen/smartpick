class Car < ActiveRecord::Base
  validates :name, :brand_id, :uid, presence: true
  validates :uid, uniqueness: true
end
