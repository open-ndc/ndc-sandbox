class CreateRoute < ActiveRecord::Migration

  def change
    create_table(:routes) do |t|
      t.references :airline
      t.string :origin, limit: 3, index: true
      t.string :destination, limit: 3, index: true
      t.string :departure_time, limit: 5
    end
  end

end
