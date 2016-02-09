class CreateService < ActiveRecord::Migration
  def change

    create_table(:services) do |t|
      t.references :airline
      t.string :name

    end

    create_table(:flight_segments_services) do |t|
      t.references :flight_segments
      t.references :services
    end
  end
end
