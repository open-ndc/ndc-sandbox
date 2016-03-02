class CreateCabin < ActiveRecord::Migration

  def change
    create_table(:cabins) do |t|
      t.references :flight_segment
      t.string :code, limit: 1
      t.string :definition, limit: 32
      t.string :columns, limit: 32
      t.integer :rows_first
      t.integer :rows_last
    end
  end

end
