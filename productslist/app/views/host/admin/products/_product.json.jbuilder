json.extract! product, :id, :sku_id, :name, :expire_date, :categories, :tags, :images, :price, :description, :created_at, :updated_at
json.url product_url(product, format: :json)
