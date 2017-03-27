class Api::V1::ProductsController < ApiController

  def create
    respond_to do |format|
      product = ProductsService.new.create_product(product_params)

      if product.valid?
        format.json {
          render(:json => {
            :product => product
          })
        }
      else
        format.json {
          render(
            :json => product.errors.full_messages.join(', '),
            :status => :unprocessable_entity,
          )
        }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.

  # Never trust parameters from the scary internet, only allow the white list through.
  def product_params
    params.require(:product).permit(
      :sku_id,
      :name,
      :expire_date,
      {:categories => []},
      {:tags => []},
      {:images => [:image_path]},
      :price,
      :description,
      :admin_approved
    )
  end
end
