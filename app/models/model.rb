class Model < ActiveRecord::Base
  validates :name, :car, :uid, presence: true
  validates :uid, uniqueness: true
  belongs_to :car
  has_many :references
end
