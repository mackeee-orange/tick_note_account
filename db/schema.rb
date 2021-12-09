# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_12_09_093725) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "accounts", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "アカウント", force: :cascade do |t|
    t.string "email", null: false, comment: "メールアドレス"
    t.string "password_digest", null: false, comment: "パスワードのハッシュ値"
    t.string "username", null: false, comment: "ユーザーネーム"
    t.integer "email_verification_status", default: 0, null: false, comment: "メールアドレスの確認状態"
    t.uuid "email_verification_token", comment: "メール確認用トークン"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_accounts_on_email", unique: true
  end

  create_table "jtis", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "JWTのホワイトリスト", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "note_taggings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "note_id", null: false
    t.uuid "tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["note_id"], name: "index_note_taggings_on_note_id"
    t.index ["tag_id"], name: "index_note_taggings_on_tag_id"
  end

  create_table "notes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "author_id", null: false
    t.string "title", null: false, comment: "タイトル"
    t.text "content", comment: "本文"
    t.datetime "expired_at", null: false, comment: "ノートの有効期限"
    t.boolean "is_public", null: false, comment: "公開されているかいなか"
    t.boolean "is_forever", default: false, null: false, comment: "永久保存版か"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_id"], name: "index_notes_on_author_id"
  end

  create_table "tags", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false, comment: "タグ名"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "votes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "account_id", null: false
    t.uuid "note_id", null: false
    t.integer "value", null: false, comment: "そのNoteに対して良くないと思ったらマイナスの値,いいと思ったらプラスの値"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_votes_on_account_id"
    t.index ["note_id"], name: "index_votes_on_note_id"
  end

  add_foreign_key "note_taggings", "notes", on_delete: :cascade
  add_foreign_key "note_taggings", "tags", on_delete: :cascade
  add_foreign_key "notes", "accounts", column: "author_id", on_delete: :cascade
  add_foreign_key "votes", "accounts", on_delete: :cascade
  add_foreign_key "votes", "notes", on_delete: :cascade
end
