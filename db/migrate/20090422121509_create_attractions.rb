class CreateAttractions < ActiveRecord::Migration
  def self.up
    create_table :attractions do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :attractions
  end
end
