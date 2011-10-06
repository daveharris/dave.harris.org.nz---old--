class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.string :name
      t.references :post

      t.timestamps
    end
    add_index :tags, :post_id
  end

  def self.down
    drop_table :tags
  end
end
