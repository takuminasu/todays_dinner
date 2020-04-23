class CreateCookingRepertoireTags < ActiveRecord::Migration[6.0]
  def change
    create_table :cooking_repertoire_tags do |t|
      t.references :cooking_repertoire, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
