class CreateBundle < ActiveRecord::Migration
  def change

    create_table(:bundles) do |t|
      t.string :name
      t.string :bundle_id
      t.integer :maximum_quantity
    end

    create_table(:bundles_fares) do |t|
      t.references :fare
      t.references :bundle
    end

    create_table(:bundles_routes) do |t|
      t.references :route
      t.references :bundle
    end

    create_table(:bundles_services) do |t|
      t.references :bundle
      t.references :service
    end
  end
end
