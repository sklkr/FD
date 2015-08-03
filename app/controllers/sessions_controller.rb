# Customer Signin, Facebook Authentication

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
      redirect_to search_path
    end
  end

  def destroy
    warden.logout
    redirect_to root_url
  end

  # Oauth authentications
  def facebook
    params[:url] = session[:book_service].blank? ? search_path : "/book_service/facebook"
    customer = Customer.find_by_email(auth_hash.info.email)
    render :text => 'User doesnot exist. Before using facebook login you must be a user at FitnessPapa' and return if customer.blank?
    if customer && customer.active
      warden.set_user(customer.user)
      redirect_to params[:url]
    else
      render :text => "Your account is not activated with FitnessPapa. Please Sign Up & Complete Registration Process"
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
