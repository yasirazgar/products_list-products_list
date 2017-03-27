class Host::Admin::ProductsController < ApplicationController
  before_action :set_product, :except => [:index]

  def index
    @products = Product.all
  end

  def edit
  end

  def update
    respond_to do |format|
      if @product.update_attributes(product_params)
        format.html { redirect_to(:action => :index)}
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # only xhr
  def add_category
    category = ProductsService.new.find_or_create_tag_or_product(Category, name_from_params)

    if !@product.categories.include?(category)
      @product.categories << category

      render_add_success_json(t('product.category_added'), category, 'category')
    else
      render_add_error_json
    end
  end

  # only xhr
  def add_tag
    tag = ProductsService.new.find_or_create_tag_or_product(Tag, name_from_params)

    if !@product.tags.include?(tag)
      @product.tags << tag

      render_add_success_json(t('product.tag_added'), tag, 'tag')
    else
      render_add_error_json
    end
  end

  # only xhr
  def remove_category
    category_id = params.require(:context_id)

    @product.categories.where(:id => category_id).first.destroy

    render_remove_success_json
  end

  # only xhr
  def remove_tag
    tag_id = params.require(:context_id)

    @product.tags.where(:id => tag_id).first.destroy

    render_remove_success_json
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  def render_add_error_json
    render(:text => t('common.already_exists'),
           :status => :unprocessable_entity,
    )
  end

  def render_remove_success_json
    render(:json => {
      :message => t('common.removed_success'),
    })
  end

  def render_add_success_json(message, context, type)
    render(:json => {
      :message => message,
      :html => render_to_string(:partial => 'host/admin/products/row',
                                :locals => {:name => context.send(:name), :id => context.send(:id), :type => type})
      })
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def product_params
    params.require(:product).permit(:name, :expire_date, :price, :description, :admin_approved)
  end

  def name_from_params
    name = params.require(:name)
  end

end
