class CreateService < ActiveRecord::Migration
  def change

    create_table(:services) do |t|
      t.references :airline
      t.string :name
      t.string :service_id
      t.string :owner
      t.string :description_text
      t.string :description_link
      t.string :description_object_id
      t.string :settlement_code
      t.string :settlement_definition
      t.integer :price_total
      t.string :price_passanger_reference
    end

    create_table(:routes_services) do |t|
      t.references :route
      t.references :service
    end
  end
end
