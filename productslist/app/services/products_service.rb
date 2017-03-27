class ProductsService

  def create_product(params)
    product_params = params

    cat_params = product_params.delete(:categories)
    tag_params = product_params.delete(:tags)
    product = Product.create(product_params)

    add_categories_to_product(cat_params, product)

    add_tags_to_product(tag_params, product)

    product
  end

  private

  def add_categories_to_product(category_names, product)
    category_names.each {|cat_name|
      product.categories << Category.create(:name => cat_name)
    }
  end

  def add_tags_to_product(tag_names, product)
    tag_names.each {|tag_name|
      product.tags << Tag.create(:name => tag_name)
    }
  end
end
