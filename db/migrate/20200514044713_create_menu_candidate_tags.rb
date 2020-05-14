class CreateMenuCandidateTags < ActiveRecord::Migration[6.0]
  def change
    create_table :menu_candidate_tags do |t|
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
