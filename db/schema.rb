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

ActiveRecord::Schema[8.0].define(version: 2025_02_12_151703) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "class_rooms", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_class_rooms_on_name", unique: true
  end

  create_table "feedbacks", force: :cascade do |t|
    t.bigint "task_id", null: false
    t.bigint "user_id", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_feedbacks_on_task_id"
    t.index ["user_id"], name: "index_feedbacks_on_user_id"
  end

  create_table "professors_subjects", id: false, force: :cascade do |t|
    t.bigint "professor_id", null: false
    t.bigint "subject_id", null: false
    t.index ["professor_id", "subject_id"], name: "index_professors_subjects_on_professor_id_and_subject_id", unique: true
    t.index ["professor_id"], name: "index_professors_subjects_on_professor_id"
    t.index ["subject_id"], name: "index_professors_subjects_on_subject_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_subjects_on_name", unique: true
  end

  create_table "subjects_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "subject_id", null: false
    t.index ["subject_id", "user_id"], name: "index_subjects_users_on_subject_id_and_user_id"
    t.index ["user_id", "subject_id"], name: "index_subjects_users_on_user_id_and_subject_id"
  end

  create_table "task_statuses", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.bigint "task_id", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_task_statuses_on_student_id"
    t.index ["task_id"], name: "index_task_statuses_on_task_id"
  end

  create_table "task_submissions", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.bigint "task_id", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_task_submissions_on_student_id"
    t.index ["task_id"], name: "index_task_submissions_on_task_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.datetime "deadline", null: false
    t.bigint "class_room_id", null: false
    t.bigint "topic_id", null: false
    t.bigint "professor_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["class_room_id"], name: "index_tasks_on_class_room_id"
    t.index ["professor_id"], name: "index_tasks_on_professor_id"
    t.index ["topic_id"], name: "index_tasks_on_topic_id"
  end

  create_table "topics", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "subject_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_topics_on_name", unique: true
    t.index ["subject_id"], name: "index_topics_on_subject_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.integer "role", default: 2, null: false
    t.bigint "class_room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["class_room_id"], name: "index_users_on_class_room_id"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "feedbacks", "tasks"
  add_foreign_key "feedbacks", "users"
  add_foreign_key "professors_subjects", "subjects"
  add_foreign_key "professors_subjects", "users", column: "professor_id"
  add_foreign_key "task_statuses", "tasks"
  add_foreign_key "task_statuses", "users", column: "student_id"
  add_foreign_key "task_submissions", "tasks"
  add_foreign_key "task_submissions", "users", column: "student_id"
  add_foreign_key "tasks", "class_rooms"
  add_foreign_key "tasks", "topics"
  add_foreign_key "tasks", "users", column: "professor_id"
  add_foreign_key "topics", "subjects"
  add_foreign_key "users", "class_rooms"
end
