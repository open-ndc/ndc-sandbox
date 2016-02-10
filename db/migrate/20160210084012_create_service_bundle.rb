class CreateServiceBundle < ActiveRecord::Migration
  def change

    create_table(:service_bundles) do |t|
      t.string :name
      t.string :bundle_id
      t.integer :maximum_quantity
    end

    create_table(:fares_service_bundles) do |t|
      t.references :fare
      t.references :service_bundle
    end

    create_table(:service_bundles_services) do |t|
      t.references :service_bundle
      t.references :service
    end
  end
end
