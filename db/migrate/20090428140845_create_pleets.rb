class CreatePleets < ActiveRecord::Migration
  def self.up
    create_table :pleets do |t|
      t.string :author
      t.string :msg
      t.string :origin
      t.string :pleet_id
      t.datetime :time
      t.timestamps
    end
  end

  def self.down
    drop_table :pleets
  end
end
