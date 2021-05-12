class CreateJoinTableClientsWeightsNutritionNutritionSpecification < ActiveRecord::Migration[6.1]
  def change
    create_join_table :clients_weights_nutritions, :nutrition_specifications do |t|
      t.index [:clients_weights_nutrition_id, :nutrition_specification_id], name: 'index_client_weights_nutrition_nutrition_specs'
      t.index [:nutrition_specification_id, :clients_weights_nutrition_id], name: 'index_nutrition_specs_client_weights_nutrition'
    end
  end
end
