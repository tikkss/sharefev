class CreateTimelines < ActiveRecord::Migration
  def change
    create_table :timelines do |t|
      t.references :book_history
      t.references :bookmark
      t.string :hit_text

      t.datetime :created_at, null: false
    end
    add_index :timelines, [:book_history_id, :bookmark_id]
    add_index :timelines, :book_history_id
    add_index :timelines, :bookmark_id
  end
end
