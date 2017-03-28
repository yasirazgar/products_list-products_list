require_relative '../../../test_helper.rb'

class Host::Admin::ProductsControllerTest < ActionController::TestCase
  setup do
    ActionController::Base.allow_forgery_protection = false
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

  test "Should add a new tag to product" do
    name = 'Tag name'
    xhr(:post, :add_tag, :id => @product, :name => name)
    assert_response(:success)
    assert_equal(true, JSON.parse(@response.body)['html'].present?,
      "Should send back html response")
    assert_equal(I18n.t('product.tag.add_success'), JSON.parse(@response.body)['message'],
      "Should send back html response")
    assert_equal(name, @product.tags.last.name)
  end

  test "Should not add a duplicate tag to product" do
    cat = tags(:one)
    xhr(:post, :add_tag, :id => @product, :name => cat.name)
    assert_response(:unprocessable_entity)
    assert_equal(I18n.t('product.tag_already_exists'), @response.body,
      "Should back html response")
  end

  test "Should add a new category to product" do
    name = 'Category name'
    xhr(:post, :add_category, :id => @product, :name => name)
    assert_response(:success)
    assert_equal(true, JSON.parse(@response.body)['html'].present?,
      "Should back html response")
    assert_equal(I18n.t('product.category.add_success'), JSON.parse(@response.body)['message'],
      "Should send back html response")
    assert_equal(name, @product.categories.last.name)
  end

  test "Should not add a duplicate category to product" do
    cat = categories(:one)
    xhr(:post, :add_category, :id => @product, :name => cat.name)
    assert_response(:unprocessable_entity)

    assert_equal(I18n.t('product.category_already_exists'),  @response.body,
      "Should back html response")
  end

  test "Should remove the tag from product" do
    tag = tags(:one)
    assert_equal(tag, @product.tags.first)
    xhr(:delete, :remove_tag, :id => @product, :context_id => tag.id)
    assert_response(:success)
    assert_equal(I18n.t('product.tag_removed'), JSON.parse(@response.body)['message'],
      "Should send back message")
    assert_equal(true, @product.tags.blank?)
  end

  test "Should remove the category from product" do
    category = categories(:one)
    assert_equal(category, @product.categories.first)
    xhr(:delete, :remove_category, :id => @product, :context_id => category.id)
    assert_response(:success)
    assert_equal(I18n.t('product.category_removed'), JSON.parse(@response.body)['message'])
    assert_equal(true, @product.categories.blank?)
  end

  private

  def product_params
    {
      :description => 'product.description',
      :expire_date => '12-09-2012',
      :name => 'product.name',
      :price => 'product.price',
    }

  end

end
