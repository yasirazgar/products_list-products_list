class CreateProducts < ActiveRecord::Migration
  def up
    create_table :products do |t|
      t.string :sku_id, :null => false
      t.string :name
      t.date :expire_date
      t.text :images
      t.column :price, 'int(11) unsigned', :default => 0
      t.text :description
      t.boolean :admin_approved, :default => false

      t.timestamps
    end

    create_table :categories do |t|
      t.string :name
    end

    create_table :products_categories do|t|
      t.belongs_to :product, :index => true
      t.belongs_to :category, :index => true
    end

    create_table :tags do |t|
      t.string :name
    end

    create_table :products_tags do|t|
      t.belongs_to :product, :index => true
      t.belongs_to :tag, :index => true
    end
  end

  # rake db:migrate:down VERSION=20170323044955
  def down
    drop_table(:products)

    drop_table(:categories)
    drop_table(:products_categories)

    drop_table(:tags)
    drop_table(:products_tags)
  end
end
