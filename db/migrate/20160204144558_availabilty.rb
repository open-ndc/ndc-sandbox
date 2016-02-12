class Availabilty < ActiveRecord::Migration
  #BitMask
  WHOLE_WEEK = '1111111'.to_i(2).to_s(10)
  def change
    add_column :flight_segments, :departure_mask, :integer, default: WHOLE_WEEK
    add_column :flight_segments, :arrival_mask, :integer, default: WHOLE_WEEK
  end
end
