class Reference < ActiveRecord::Base
  validates :price, :model_id, :date, presence: true
  validates :model_id, uniqueness: { scope: :date }
end
