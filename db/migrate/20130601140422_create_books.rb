# -*- encoding : utf-8 -*-
class CreateBooks < ActiveRecord::Migration
  def self.up
    create_table :books do |t|
      t.string :name, limit: 2
      t.string :title, limit: 10
      t.string :checked_url
      t.string :linked_url
      t.timestamps
    end
  end

  def self.down
    drop_table :books
  end
end
