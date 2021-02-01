class CreateRhymes < ActiveRecord::Migration
  def change
    create_table :rhymes do |t|
      t.integer :song_id, null: false
      t.text :body, null: false
      t.text :color, null: false

      t.timestamps null: false
    end
    add_reference :rhymes, :author, references: :users, index: true
    add_foreign_key :rhymes, :users, column: :author_id
    add_foreign_key :rhymes, :songs
    add_index :rhymes, [:song_id]
    add_index :rhymes, [:song_id, :color], unique: true
  end
end
