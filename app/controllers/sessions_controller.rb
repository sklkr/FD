class SessionsController < ApplicationController
skip_before_filter :authenticate!
layout 'homepage'

  def new
    
  end

  def create
    authenticate!
    unless params[:url].nil?
      redirect_to params[:url]
    else
      redirect_to search_path, :notice => "Signed in successfully"
    end
  end

  def destroy
    warden.logout
    redirect_to root_url, :notice => "Signed out successfully"
  end

  # Oauth authentications
  def facebook
    customer = Customer.find_by_email(auth_hash.info.email)
    if customer.nil?
      customer = Customer.new(params_builder)  
      if customer.save
        warden.set_user(customer.user)
        redirect_to search_path    
      else
        render :text => 'something went wrong'
      end
    else
      if customer.identity.nil?
        # User already exists with normal signup
        flash[:notice] = 'Email already member with normal signup'
        redirect_to root_url
      else
        # signin
        warden.set_user(customer.user)
        redirect_to search_path    
      end
    end
  end

  private
    def params_builder
      list = {:email => auth_hash.info.email}
      user_attributes = {:first_name => auth_hash.info.first_name, :last_name => auth_hash.info.last_name}
      identity_attributes = {:provider => auth_hash.provider, :uid => auth_hash.uid}
      list.merge!({:user_attributes => user_attributes})
      list.merge!({:identity_attributes => identity_attributes})
    end
end
