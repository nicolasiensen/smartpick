class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.string :name
      t.integer :brand_id
      t.string :uid

      t.timestamps
    end
  end
end
