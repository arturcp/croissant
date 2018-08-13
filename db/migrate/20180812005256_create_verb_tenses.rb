class CreateVerbTenses < ActiveRecord::Migration[5.2]
  def change
    create_table :verb_tenses do |t|
      t.references :tense_mode
      t.string :tense
    end
  end
end
