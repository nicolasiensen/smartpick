class DropReferences < ActiveRecord::Migration
  def change
    drop_table :references do |t|
      t.float :price
      t.integer :model_id
      t.date :date

      t.timestamps
    end
  end
end
