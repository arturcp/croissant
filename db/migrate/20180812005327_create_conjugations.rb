class CreateConjugations < ActiveRecord::Migration[5.2]
  def change
    create_table :conjugations do |t|
      t.references :verbs
      t.references :verb_tenses
      t.string :je
      t.string :tu
      t.string :il
      t.string :nous
      t.string :vous
      t.string :ils
    end
  end
end
