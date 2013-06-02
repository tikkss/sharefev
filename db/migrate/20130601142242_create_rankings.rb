# -*- encoding : utf-8 -*-
class CreateRankings < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.references :timeline
      t.string :ip_address, limit: 32

      t.datetime :created_at, null: false
    end
    add_index :rankings, :timeline_id
  end
end
