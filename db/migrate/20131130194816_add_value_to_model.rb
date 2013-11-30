class AddValueToModel < ActiveRecord::Migration
  def change
    add_column :models, :value, :float
  end
end
