Warden::Manager.serialize_into_session do |user|
  user.id
end

Warden::Manager.serialize_from_session do |id|
  User.find_by_id(id)
end

Warden::Manager.serialize_into_session(:superadmin) do |superadmin|
  superadmin.id
end

Warden::Manager.serialize_from_session(:superadmin) do |id|
  Superadmin.find_by_id(id)
end

class CustomerStrategy < ::Warden::Strategies::Base
  def valid?
    return false if request.get?
    user_data = params.fetch("user")
    !(user_data["email"].blank? || user_data["password"].blank?)
  end

  def authenticate!
    customer = Customer.find_by_email(params["user"].fetch("email"))
    if customer.nil? || customer.user.password != params["user"].fetch("password") || customer.user.active == false
      fail! :message => "strategies.password.failed"
    else
      success! customer.user
    end
  end
end

class PartnerStrategy < ::Warden::Strategies::Base
  def valid?
    return false if request.get?
    user_data = params.fetch("user")
    !(user_data["email"].blank? || user_data["password"].blank?)
  end

  def authenticate!
    partner = Partner.find_by_email(params["user"].fetch("email"))
    if partner.nil? || partner.user.password != params["user"].fetch("password") || partner.user.active == false
      fail! :message => "strategies.password.failed"
    else
      success! partner.user
    end
  end
end

class SuperadminStrategy < ::Warden::Strategies::Base
  def valid?
    return false if request.get?
    user_data = params.fetch("user")
    !(user_data["email"].blank? || user_data["password"].blank?)
  end

  def authenticate!
    superadmin = Superadmin.find_by_email(params["user"].fetch("email"))
    if superadmin.try(:user).nil? || superadmin.user.password != params["user"].fetch("password")
      fail!("could not logged in")
    else
      success! superadmin
    end
  end
end







# Facebok Strategy :: ___________________________________________________________________



Warden::Strategies.add(:customer, CustomerStrategy)
Warden::Strategies.add(:partner, PartnerStrategy)
Warden::Strategies.add(:superadmin, SuperadminStrategy)
