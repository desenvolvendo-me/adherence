# app/controllers/products_controller.rb
class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @q = Product.ransack(params[:q])
    @products = @q.result
                  .order(code: :asc)
                  .page(params[:page])

    respond_to do |format|
      format.html
      format.turbo_stream {
        render turbo_stream: turbo_stream.update("products_list",
                                                 partial: "products_table",
                                                 locals: { products: @products }
        )
      }
    end
  end

  def show
  end

  def new
    @product = Product.new
    @product.machine_products.build
  end

  def edit
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to products_path, notice: 'Produto criado com sucesso.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      redirect_to products_path, notice: 'Produto atualizado com sucesso.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.update(status: :inactive)
    redirect_to products_path, notice: 'Produto inativado com sucesso.'
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(
      :code,
      :name,
      :standard_time,
      :setup_time,
      :status,
      machine_products_attributes: [
        :id,
        :machine_id,
        :_destroy
      ]
    )
  end
end