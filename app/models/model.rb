class Model < ActiveRecord::Base
  validates :name, :car_id, :uid, presence: true
  validates :uid, uniqueness: true
end
