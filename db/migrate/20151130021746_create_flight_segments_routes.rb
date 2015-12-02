class CreateFlightSegmentsRoutes < ActiveRecord::Migration

  def change
    create_table(:flight_segments_routes) do |t|
      t.references :flight_segment
      t.references :route
    end
  end

end
