class CreateSeat < ActiveRecord::Migration

  def change
    create_table(:seats) do |t|
      t.references :cabin
      t.string :column, limit: 1
      t.string :row, limit: 32
      t.string :list_key, limit: 8
      t.string :characteristic, limit: 32
    end
  end

end
