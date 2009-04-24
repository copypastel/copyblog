class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string  :user_name
      t.text    :comment
      t.belongs_to :attraction
      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
