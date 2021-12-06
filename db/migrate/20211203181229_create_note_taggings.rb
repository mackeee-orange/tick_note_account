class CreateNoteTaggings < ActiveRecord::Migration[6.1]
  def change
    create_table :note_taggings, id: :uuid do |t|
      t.references :note, type: :uuid, null: false, foreign_key: { on_delete: :cascade }
      t.references :tag, type: :uuid, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
