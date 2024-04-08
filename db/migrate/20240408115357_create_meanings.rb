class CreateMeanings < ActiveRecord::Migration[7.1]
  def change
    create_table :meanings do |t|
      t.references :word
      t.string :part_of_speech
      t.text :definition, null: false

      t.timestamps
    end
  end
end
