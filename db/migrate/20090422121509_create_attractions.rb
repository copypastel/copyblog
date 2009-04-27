class CreateAttractions < ActiveRecord::Migration
  def self.up
    create_table :attractions do |t|
      t.string :title
      t.text   :body
      t.string :author
      t.string :img_url
      t.datetime :when
      t.string :outline
      t.string :verb
      t.timestamps
    end
  end

  def self.down
    drop_table :attractions
  end
end
