class CreateWords < ActiveRecord::Migration[7.1]
  def change
    create_table :words do |t|
      t.string :word, null: false
      t.string :syllabic_division

      t.timestamps
    end
  end
end
