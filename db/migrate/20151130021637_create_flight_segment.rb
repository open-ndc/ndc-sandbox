class CreateFlightSegment < ActiveRecord::Migration

  def change
    create_table(:flight_segments) do |t|
      t.references :airline
      t.string :number, limit: 4
      t.string :key, limit: 6
      t.string :origin, limit: 3
      t.string :destination, limit: 3
      t.string :departure_terminal, limit: 12
      t.string :departure_time, limit: 5
      t.string :arrival_terminal, limit: 12
      t.string :arrival_time, limit: 5
      t.integer :arrival_date_delta, default: 0
      t.string :aircraft, limit: 3
    end
  end

end
