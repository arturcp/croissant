class CreateTenseModes < ActiveRecord::Migration[5.2]
  def change
    create_table :tense_modes do |t|
      t.string :name
    end
  end
end
