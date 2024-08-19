class ProductsController < ApplicationController



  def index
    if search_params[:search_filter].present?
      @nfces = search
    else
      @nfces = []
    end
  end

  private




  def search
    query = search_params[:search_filter]
    product_nome = Product.arel_table[:nome]
     current_customer.nfces
    .joins(:products)
    .where(product_nome.matches("%#{query}%"))
    .distinct

  end


  def search_params
    params.permit(:search_filter)
  end



end
