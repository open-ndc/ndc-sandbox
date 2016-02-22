class CreateRoute < ActiveRecord::Migration

  def change
    enable_extension 'hstore' unless extension_enabled?('hstore')
    create_table(:routes) do |t|
      t.references :airline
      t.string :origin, limit: 3, index: true
      t.string :destination, limit: 3, index: true
      t.string :dow, limit: 3, index: true
      t.hstore 'dow'
    end
  end

end
