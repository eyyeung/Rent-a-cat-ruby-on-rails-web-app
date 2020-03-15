class CreateCats < ActiveRecord::Migration[6.0]
  def change
    create_table :cats do |t|
      t.string :name, null:false, unique: true
      t.date :birth_date, null:false
      t.string :color, null:false
      t.string :sex, null:false, :limit=>1
      t.text :description, null:false
      t.timestamps
    end
  end
end
