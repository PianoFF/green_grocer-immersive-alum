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
  # binding.pry
  cart.each_value do |v| 
    if v[:clearance] == true
      v[:price] -= (v[:price] * 0.2).round(2)
    end
  end
  cart 
end

def checkout(cart, coupons)
  # code here
  total_price = 0
  couponed_cart = nil
  
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(couponed_cart)
  
  final_cart.each_value do|item_hsh|
    total_price += (item_hsh[:price] * item_hsh[:count])
  end
    
  if total_price > 100
    total_price *= 0.9
  end

  total_price
end
