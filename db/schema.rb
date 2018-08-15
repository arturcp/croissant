# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_08_12_010136) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "conjugations", force: :cascade do |t|
    t.bigint "verb_id"
    t.bigint "verb_tense_id"
    t.string "je"
    t.string "tu"
    t.string "il"
    t.string "nous"
    t.string "vous"
    t.string "ils"
    t.index ["verb_id"], name: "index_conjugations_on_verb_id"
    t.index ["verb_tense_id"], name: "index_conjugations_on_verb_tense_id"
  end

  create_table "tense_modes", force: :cascade do |t|
    t.string "name"
  end

  create_table "verb_tenses", force: :cascade do |t|
    t.bigint "tense_mode_id"
    t.string "tense"
    t.index ["tense_mode_id"], name: "index_verb_tenses_on_tense_mode_id"
  end

  create_table "verbs", force: :cascade do |t|
    t.string "verb"
    t.string "translation"
  end

end
