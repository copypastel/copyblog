class CreateGithubProjects < ActiveRecord::Migration
  def self.up
    create_table :github_projects do |t|
      t.date    :last_updated
      t.text    :name
      t.boolean :tag
      t.string  :url

      t.timestamps
    end
  end

  def self.down
    drop_table :github_projects
  end
end
