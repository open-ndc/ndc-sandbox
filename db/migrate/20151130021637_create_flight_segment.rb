class CreateFlightSegment < ActiveRecord::Migration

  def change
    create_table(:flight_segments) do |t|
      t.references :airline
      t.string :number, limit: 4
      t.string :key, limit: 6
      t.string :departure_airport_code, limit: 3
      t.string :departure_airport_name
      t.string :departure_terminal, limit: 3
      t.string :departure_time, limit: 5
      t.string :arrival_airport_code, limit: 3
      t.string :arrival_airport_name
      t.string :arrival_terminal, limit: 3
      t.string :arrival_time, limit: 5
      t.integer :duration
      t.integer :distance
      t.integer :distance_units
      t.string :aircraft, limit: 3
      t.string :marketing_carrier, limit: 3
      t.string :operating_carrier, limit: 3
    end
  end

end
