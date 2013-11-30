class DropComparesModels < ActiveRecord::Migration
  def change
    drop_table :compares_models do |t|
      t.integer :compare_id
      t.integer :model_id
    end
  end
end
