class CreateFare < ActiveRecord::Migration

  def change
    create_table(:fares) do |t|
      t.references :route
      t.string :class, limit: 1
      t.string :currency, limit: 3
      t.integer :base_price
    end
  end

end
