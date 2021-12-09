class CreateVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :votes, id: :uuid do |t|
      t.references :account, type: :uuid, null: false, foreign_key: { on_delete: :cascade }
      t.references :note, type: :uuid, null: false, foreign_key: { on_delete: :cascade }
      t.integer :value, null: false, comment: 'そのNoteに対して良くないと思ったらマイナスの値,いいと思ったらプラスの値'

      t.timestamps
    end
  end
end
