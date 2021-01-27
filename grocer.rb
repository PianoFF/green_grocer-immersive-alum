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
  

end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here

end
