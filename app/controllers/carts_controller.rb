class CartsController < ApplicationController

  def show
  end

  def add_item
    product_id = params[:product_id].to_s
    modify_cart_delta(product_id, +1)
    redirect_back fallback_location: root_path
  end

  def remove_item
    product_id = params[:product_id].to_s
    modify_cart_delta(product_id, -1)

    redirect_back fallback_location: root_path
  end

  def create
    product = Product.find(params[:product_id])
    if product.quantity > 0
      product.decrement!(:quantity, by = 1)
      cart.add_item(product.id)
      redirect_to cart_path, notice: 'Item added to cart'
    else
      redirect_to products_path, alert: 'Item is sold out'
    end
  end

  private

  


  def modify_cart_delta(product_id, delta)
    cart[product_id] = (cart[product_id] || 0) + delta
    cart.delete(product_id) if cart[product_id] < 1
    update_cart cart
  end

end
