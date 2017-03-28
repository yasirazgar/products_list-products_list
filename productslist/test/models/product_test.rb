require_relative '../test_helper.rb'

class ProductTest < ActiveSupport::TestCase
  test "first_image_url" do
    image_url = 'folder/image1'

    assert_equal(image_url,
      Product.new(
        :images => [
          {:image_path => image_url},
          {:image_path => 'folder/image2'},
          ]).first_image_url,
      "Should return first images url")
  end

  test "scope with tag" do
    # products(:tag_one), name = tag1
    assert_equal([products(:one)],
      Product.with_tag('tag1'),
      "Should return prodcuts with given tag name")
  end

  test "scope with category" do
    # products(:category_one), name = category1
    assert_equal([products(:one)],
      Product.with_category('category1'),
      "Should return prodcuts with given category name")
  end



end
