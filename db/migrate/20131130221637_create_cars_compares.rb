class CreateCarsCompares < ActiveRecord::Migration
  def change
    create_table :cars_compares do |t|
      t.integer :car_id
      t.integer :compare_id
    end
  end
end
