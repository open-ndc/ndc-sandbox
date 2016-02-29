class CreateAircraft < ActiveRecord::Migration

  def change
    create_table(:aircrafts) do |t|
      t.references :flight_segment
      t.string :model, limit: 32
      t.string :name, limit: 128
      t.string :code, limit: 6
    end
  end

end
