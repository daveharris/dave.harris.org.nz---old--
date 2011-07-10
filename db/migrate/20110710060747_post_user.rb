class PostUser < ActiveRecord::Migration
  def self.up
    remove_column :posts, :name
    
    change_table :posts do |t|
      t.references :user
    end
  end

  def self.down
    remove_column :posts, :user
    add_column :posts, :name, :string
  end
end
