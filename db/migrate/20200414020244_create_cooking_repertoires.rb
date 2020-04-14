class CreateCookingRepertoires < ActiveRecord::Migration[6.0]
  def change
    create_table :cooking_repertoires do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
