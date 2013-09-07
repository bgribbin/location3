class AddRegionToRegions < ActiveRecord::Migration
  def change
    add_column :regions, :region, :string
    add_index :regions, :region
  end
end
