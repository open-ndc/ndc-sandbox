class CreateAirline < ActiveRecord::Migration

  def change
    create_table(:airlines) do |t|
      t.column :code, :string, limit: 2, null: false, index: true  #IATA code
      t.column :short_name, :string, limit: 20, null: false
      t.column :name, :string, limit: 50
    end
  end

end
