class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.point :coords, :srid => 3785

      t.timestamps
    end
    change_table :answers do |t|
    	t.index :coords, :spatial => true
    end
  end
end
