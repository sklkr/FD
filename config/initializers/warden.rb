Warden::Manager.serialize_into_session do |user|
  user.id
end

Warden::Manager.serialize_from_session do |id|
  User.find_by_id(id)
end


class CustomerStrategy < ::Warden::Strategies::Base
  def valid?
    return false if request.get?
    user_data = params.fetch("user")
    !(user_data["email"].blank? || user_data["password"].blank?)
  end

  def authenticate!
    binding.pry
    customer = Customer.find_by_email(params["user"].fetch("email"))
    if customer.nil? || customer.user.password != params["user"].fetch("password")
      fail! :message => "strategies.password.failed"
    else
      success! customer
    end
  end
end

Warden::Strategies.add(:customer, CustomerStrategy)
