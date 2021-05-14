class ChangeTypeColumnNameFoods < ActiveRecord::Migration[6.1]
  def change
    rename_column :foods, :type, :food_type
  end
end
