# -*- encoding : utf-8 -*-
class AddHiddenToCw < ActiveRecord::Migration
  def self.up
    add_column :coursewares,:hidden,:boolean
  end

  def self.down
    remove_column :coursewares,:hidden
  end
end
