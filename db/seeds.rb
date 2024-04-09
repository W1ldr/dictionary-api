# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

require 'sqlite3'
require 'active_record'

sqlite_db = SQLite3::Database.new 'dataset.db'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'dataset.db'
)

word_table = sqlite_db.table_info('word').any?



# Iterate over SQLite word table and insert data into PostgreSQL
if word_table 
  # persist the info of word table
  sqlite_db.execute("SELECT * FROM word").each do |row|
    word = Word.find_or_initialize_by(w: row['w'])
    word.save(w: row['w']) if word.new_record?
  end
else
    # Define schema for your table (optional if table already exists)
    ActiveRecord::Schema.define do
      create_table :word do |t|
        t.string :w
        t.string :link
        # Add more columns as needed
      end
    end
end

sqlite_db.close

