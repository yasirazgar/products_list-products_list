require_relative '../../../test_helper.rb'

class Api::V1::ProductsControllerTest < ActionController::TestCase
  setup do
    @product = products(:one)
  end

  test "should create product" do
    params = product_params
    post(:create, product_params)
    assert_response(:ok)

    cat_params = params[:product].delete(:categories)
    tag_params = params[:product].delete(:tags)
    images = params[:product].delete(:images)

    product = Product.where(:sku_id => params[:product][:sku_id]).first

    assert(product.present?)
    params[:product].each do |k,v|
      assert_equal(v.to_s, product.send(k).to_s)
    end

    assert_equal(images, product.images.map(&:symbolize_keys))
    assert_equal(cat_params, product.categories.map(&:name))
    assert_equal(tag_params, product.tags.map(&:name))
  end

  test "should not create product with duplicate sku_id" do
    params = product_params
    params[:product][:sku_id] = products(:one).sku_id
    post(:create, params)

    assert_response(:unprocessable_entity)

    assert_equal("Sku has already been taken", @response.body)
  end

  private

  def product_params
    {
      :product => {
        :categories => ['cat1, cat2'],
        :description => "Prod desc",
        :expire_date => '2018-09-09',
        :images => [{:image_path => 'folder/image_name'}, {:image_path => 'folder/image_name'}],
        :name => 'Prod name',
        :price => 20,
        :sku_id => '23id',
        :tags => ['tag1', 'tag2'],
      },
      :format => 'json'
    }

  end

end
