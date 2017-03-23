class CreateProducts < ActiveRecord::Migration
  def up
    create_table :products do |t|
      t.string :sku_id, :null => false
      t.string :name
      t.date :expire_date
      t.text :categories
      t.text :tags
      t.text :images
      t.column :price, 'int(11) unsigned', :default => 0
      t.text :description
      t.boolean :admin_approved, :default => false

      t.timestamps
    end
  end

  # rake db:migrate:down VERSION=20170323044955
  def down
    drop_table(:products)
  end
end
