class CreateReferences < ActiveRecord::Migration
  def change
    create_table :references do |t|
      t.float :price
      t.integer :model_id
      t.date :date

      t.timestamps
    end
  end
end
