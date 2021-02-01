class CreateSyllables < ActiveRecord::Migration
  def change
    create_table :syllables do |t|
      t.integer :rhyme_id, null: false
      t.text :body, null: false
      t.integer :start_index, null: false
      t.integer :end_index, null: false

      t.timestamps null: false
    end
    add_reference :syllables, :author, references: :users, index: true
    add_foreign_key :syllables, :users, column: :author_id
    add_foreign_key :syllables, :rhymes
    add_index :syllables, [:rhyme_id]
    add_index :syllables, [:start_index, :end_index]
  end
end
