class CreateMenus < ActiveRecord::Migration[6.0]
  def change
    create_table :menus do |t|
      t.date :date, null: false
      t.references :cooking_repertoire, null: false, foreign_key: true

      t.timestamps
      t.index :date, unique: true
    end
  end
end
