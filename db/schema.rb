# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_10_02_155448) do

  create_table "admins", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "approval_requests", force: :cascade do |t|
    t.string "student_email"
    t.string "isbn"
    t.string "title"
    t.string "author"
    t.integer "edition"
    t.string "university"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "book_requests", force: :cascade do |t|
    t.integer "library_id"
    t.string "isbn"
    t.integer "books_available"
    t.integer "books_checkedout"
    t.integer "books_holdrequest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "bookmarks", force: :cascade do |t|
    t.string "student_name"
    t.string "student_email"
    t.string "isbn"
    t.string "title"
    t.string "author"
    t.integer "edition"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "books", force: :cascade do |t|
    t.string "isbn"
    t.string "title"
    t.string "author"
    t.string "language"
    t.string "published"
    t.integer "edition"
    t.binary "image"
    t.string "subject"
    t.text "summary"
    t.boolean "special"
    t.string "library"
    t.string "university"
    t.integer "number_available"
    t.integer "number_checkedout"
    t.integer "number_holdrequest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "history_requests", force: :cascade do |t|
    t.string "library_name"
    t.string "isbn"
    t.string "status"
    t.string "student_name"
    t.string "student_email"
    t.decimal "fines", default: "0.0"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "hold_requests", force: :cascade do |t|
    t.string "student_email"
    t.string "student_name"
    t.string "isbn"
    t.string "title"
    t.string "author"
    t.integer "edition"
    t.string "university"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "librarians", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "password_digest"
    t.string "library"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "libraries", force: :cascade do |t|
    t.string "name"
    t.string "university"
    t.string "location"
    t.integer "maxdays"
    t.decimal "fine"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "students", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "password_digest"
    t.string "education"
    t.string "university"
    t.integer "maxbook"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
