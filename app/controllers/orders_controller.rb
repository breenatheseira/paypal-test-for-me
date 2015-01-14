class OrdersController < ApplicationController
  def new
     @order = Order.new(:express_token => params[:token])
  end

  def create
    @order = Order.new(order_params)
    @order.ip = request.remote_ip
  
    if @order.save
      if @order.purchase # this is where we purchase the order. refer to the model method below
        redirect_to successful_orders_url(@order)
      else
        render :action => "failure"
      end
    else
      render :action => 'new'
    end    
  end

  def express_checkout
     response = ::EXPRESS_GATEWAY.setup_purchase(150,
      ip: request.remote_ip,
      return_url: new_order_url,
      cancel_return_url: cancel_orders_url,
      currency: "USD",
      allow_guest_checkout: true,
      items: [{name: "Order", description: "Order description", quantity: "1", amount: 150}]
    )
    redirect_to ::EXPRESS_GATEWAY.redirect_url_for(response.token)
  end
  
  def failure
  end
  
  def make_orders
  end
  
  def cancel
  end
  
  def successful_orders
  end
  
  def order_params
    params.require(:order).permit(:ip, :express_token, :exxpress_payer_id)
  end
  
end
