# frozen_string_literal: true

class Api::ProductsController < ApplicationController
  before_action :set_product, only: %i[update destroy]

  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, :include => {
        :categories => { :only => %i[id name] }
      }, :except => %i[created_at updated_at], status: :created
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def update
    if @product.blank?
      render json: @product, status: :not_found
    elsif @product.update(product_params)
      render json: @product, status: :ok
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @product.blank?
      render json: @product, status: :not_found
    else
      @product.destroy!
    end
  end

  private

  def set_product
    @product = Product.find_by(id: params[:id])
  end

  def product_params
    params.require(:product).permit(:id, :url)
  end
end
