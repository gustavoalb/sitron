# -*- encoding : utf-8 -*-
class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :name
      t.datetime :start_at
      t.datetime :end_at
      t.boolean :all_day, :default => false
      t.string :color
      t.references :requisicao
      t.string :state
      
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
