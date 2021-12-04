class CreateNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :notes, id: :uuid do |t|
      t.references :author, type: :uuid, null: false, foreign_key: { to_table: :accounts, on_delete: :cascade }
      t.string :title, null: false, comment: "タイトル"
      t.text :content, null: true, comment: '本文'
      t.datetime :expired_at, null: false, comment: 'ノートの有効期限'
      t.boolean :is_public, null: false, comment: '公開されているかいなか'
      t.boolean :is_forever, null: false, default: false, comment: '永久保存版か'

      t.timestamps
    end
  end
end
