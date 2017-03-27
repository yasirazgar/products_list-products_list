=begin
schema
+----------------+------------------+------+-----+---------+----------------+
| Field          | Type             | Null | Key | Default | Extra          |
+----------------+------------------+------+-----+---------+----------------+
| id             | int(11)          | NO   | PRI | NULL    | auto_increment |
| sku_id         | varchar(255)     | NO   |     | NULL    |                |
| name           | varchar(255)     | YES  |     | NULL    |                |
| expire_date    | date             | YES  |     | NULL    |                |
| images         | text             | YES  |     | NULL    |                |
| price          | int(11) unsigned | YES  |     | 0       |                |
| description    | text             | YES  |     | NULL    |                |
| admin_approved | tinyint(1)       | YES  |     | 0       |                |
| created_at     | datetime         | YES  |     | NULL    |                |
| updated_at     | datetime         | YES  |     | NULL    |                |
+----------------+------------------+------+-----+---------+----------------+
=end

class Product < ActiveRecord::Base
  validates :sku_id, :uniqueness => true, :presence => true

  serialize :images, Array

  has_and_belongs_to_many :categories,
                          :join_table => :products_categories
  has_and_belongs_to_many :tags,
                          :join_table => :products_tags
  def images
    Array(super)
  end

  def first_image_url
    if images.present?
      images.first.with_indifferent_access[:image_path]
    end
  end
end
