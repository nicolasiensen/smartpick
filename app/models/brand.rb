class Brand < ActiveRecord::Base
  validates :name, :uid, presence: true
  validates :uid, uniqueness: true
end
