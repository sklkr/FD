class RegistrationsController < ApplicationController
 skip_before_filter :authenticate!
 layout 'homepage'

  def partner
    @cities = cities
  end

  def customer
  	
  end

  def customer_signup
     user = User.new(user_params)
     if user.save
      cdata = Customer.new(customer_params)
      cdata.user_id = user.id
       if cdata.save
        VerificationMailer.welcome_email(user, cdata).deliver
        flash[:success] = 'Please verify your email'
        redirect_to page_path('verify')
       else
       render :text => 'something went wrong'
       end
     else
      render :text => 'something went wrong'
     end
  end

  def partner_signup
    user = User.new(user_params)
    if params[:user][:password] == params[:user][:password_conf] && user.save
     pdata = Partner.new(partner_params)
     pdata.user_id = user.id
     if pdata.save
     # Directly authenticating here , change required 
      VerificationMailer.welcome_email(user, pdata).deliver
      flash[:success] = 'Please verify your email'
      redirect_to page_path('verify')
     else
      render :text => 'something went wrong'
     end
    else
      render :text => 'something went wrong'
    end 
  end

  def verify_email
    user = User.find_by_remember_token(params['token'])
    if user.active == true
      redirect_to page_path('confirmation')  if user.save
    end
    unless user.nil?  
      user.active = true
      redirect_to page_path('confirmation')  if user.save
    end
  end

  private
  	def customer_params
  		params.require(:user).permit(:email)
  	end

  	def user_params
  		params.require(:user).permit(:password, :first_name, :last_name, :city)
  	end

  	def details(base, data)
  		user = User.new(data)
  		user.member_id = base.id
  		user
  	end

    def partner_params
      params.require(:user).permit(:email, :business_name, :category_id, )
    end
end
