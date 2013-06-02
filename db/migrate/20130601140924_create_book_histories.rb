# -*- encoding : utf-8 -*-
class CreateBookHistories < ActiveRecord::Migration
  def change
    create_table :book_histories do |t|
      t.references :book
      t.integer :year
      t.string :no, limit: 8
      t.string :hit_text

      t.datetime :created_at, null: false
    end
    add_index :book_histories, :book_id
  end
end
