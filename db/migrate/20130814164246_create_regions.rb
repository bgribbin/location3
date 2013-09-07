class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.polygon :poly, :srid => 3785

      t.timestamps
    end
    change_table :regions do |t|
    	t.index :poly, :spatial => true
    end
  end
end
