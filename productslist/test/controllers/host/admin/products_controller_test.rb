require_relative '../../../test_helper.rb'

class Host::Admin::ProductsControllerTest < ActionController::TestCase
  setup do
    ActionController::Base.allow_forgery_protection = true
    @product = products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
  end

  test "should get edit" do
    get :edit, id: @product
    assert_response :success
  end

  test "should update product" do
    put :update, id: @product, product: product_params
    assert_redirected_to(:action => :index)
  end

  private

  def product_params
    {
      :categories => @product.categories,
      :description => @product.description,
      :expire_date => @product.expire_date,
      :images => [{:image => 'folder/image_name'}, {:image => 'folder/image_name'}],
      :name => @product.name,
      :price => @product.price,
      :sku_id => @product.sku_id,
      :tags => @product.tags,
    }

  end

end
