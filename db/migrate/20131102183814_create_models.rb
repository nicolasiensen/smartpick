class CreateModels < ActiveRecord::Migration
  def change
    create_table :models do |t|
      t.string :name
      t.integer :car_id
      t.string :uid

      t.timestamps
    end
  end
end
