require_relative '../test_helper.rb'

class ProductTest < ActiveSupport::TestCase
  test "first_image_url" do
    image_url = 'folder/image1'

    assert_equal(
      Product.new(
        :images => [
          {:image_path => image_url},
          {:image_path => 'folder/image2'},
          ]).first_image_url,
      "Should return first images url")
  end
end
