require 'pry'
def consolidate_cart(cart)
  # code here
  counted_cart = {}
  cart.each do |item_hsh|
    item = nil
    item_hsh.select{|k,v| item = k}
    # binding.pry
    if counted_cart[item]
      # binding.pry
      counted_cart[item][:count] += 1
    else
      item_hsh.select{|k,v| v[:count] = 1}
      # binding.pry
      counted_cart = counted_cart.merge(item_hsh)
    end
  end
  return counted_cart
end

def apply_coupons(cart, coupons)
  # code here
  # cart now looks:
  # {
  # "AVOCADO" => {:price => 3.00, :clearance => true, :count => 3},
  # "KALE"    => {:price => 3.00, :clearance => false, :count => 1}
  # }
  w_coupons = {}
  # binding.pry
  # coupons = [{:item=>"AVOCADO", :num=>2, :cost=>5.0}]
  coupons.each do |coupon_hsh|
    coupon_item = coupon_hsh[:item]
    if cart[coupon_item]
      item_total_num = cart[coupon_item][:count]
      item_num_after_discount = item_total_num % coupon_hsh[:num]
      item_num_discounted = item_total_num - item_num_after_discount
      item_discounted_price = coupon_hsh[:cost]/coupon_hsh[:num].to_f

      w_coupons["#{coupon_item} W/COUPON"] = Hash[
        [
          [:price, item_discounted_price],
          [:clearance, (cart[coupon_item][:clearance])],
          [:count, item_num_discounted]
        ]
      ]
      cart[coupon_item][:count] = item_num_after_discount
    end
  end
  cart = cart.merge(w_coupons)
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here

end
