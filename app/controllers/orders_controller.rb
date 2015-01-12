class OrdersController < ApplicationController
  def new
     @order = Order.new(:express_token => params[:token])
  end

  def create
  end

  def express_checkout
     response = EXPRESS_GATEWAY.setup_purchase(150,
      ip: request.remote_ip,
      return_url: success_orders_path,
      cancel_return_url: cancel_orders_path,
      currency: "USD",
      allow_guest_checkout: true,
      items: [{name: "Order", description: "Order description", quantity: "1", amount: 150}]
    )
    redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
  end
  
  def make_orders
  end
  
  def cancel
  end
  
  def success
  end
end
