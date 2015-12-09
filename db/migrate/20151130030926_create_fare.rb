class CreateFare < ActiveRecord::Migration

  def change
    create_table(:fares) do |t|
      t.references :route
      t.string :service_class, limit: 1
      t.string :currency, limit: 3
      t.integer :base_price
      t.integer :range_days_increase
      t.float :rate_increase
      t.float :taxes_applicable
    end
  end

end
