module UsersHelper
  def billing_address_url
    if @billing_address.id
      "/billing_addresses/update/#{@billing_address.id}"
    else
      "/billing_addresses/create"
    end
  end

  def shipping_address_url
    if @shipping_address.id
      "/shipping_addresses/update/#{@shipping_address.id}"
    else
      "/shipping_addresses/create"
    end
  end

  def address_method(object)
    if object.id
      :patch
    else
      :post
    end
  end

end