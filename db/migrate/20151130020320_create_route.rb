class CreateRoute < ActiveRecord::Migration

  def change
    create_table(:routes) do |t|
      t.references :airline
      t.string :origin, limit: 3, index: true
      t.string :destination, limit: 3, index: true
    end
  end

end
