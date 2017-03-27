=begin
schema
+----------------+------------------+------+-----+---------+----------------+
| Field          | Type             | Null | Key | Default | Extra          |
+----------------+------------------+------+-----+---------+----------------+
| id             | int(11)          | NO   | PRI | NULL    | auto_increment |
| name           | varchar(255)     | YES  |     | NULL    |                |
+----------------+------------------+------+-----+---------+----------------+
=end

class Category < ActiveRecord::Base
  has_and_belongs_to_many :products,
                          :join_table => :products_categories
end
