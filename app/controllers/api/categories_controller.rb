# frozen_string_literal: true

class Api::CategoriesController < ApplicationController

  def index
    @categories = Category.all
    render json: @categories, :include => {
      :products => {
        :methods => :product_images,
        :only => %i[id url title size description price mobile_number product_images]
      }
    }, :except => %i[created_at updated_at]
  end
end
