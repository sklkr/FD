class RegistrationsController < ApplicationController
 skip_before_filter :authenticate!
 layout 'homepage'

  def partner
  end

  def customer
  	
  end

  def customer_signup
  	 cdata = Customer.new(customer_params)
     if cdata.save
      use = details(cdata, user_params)
       if use.save
        VerificationMailer.welcome_email(use, cdata).deliver
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
    pdata = Partner.new(partner_params)
    if params[:user][:password] == params[:user][:password_conf] && pdata.save
    use = details(pdata, user_params)
     if use.save
     # Directly authenticating here , change required 
      VerificationMailer.welcome_email(use, pdata).deliver
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
  		params.require(:user).permit(:password, :first_name, :last_name)
  	end

  	def details(base, data)
  		user = User.new(data)
  		user.member_id = base.id
  		user
  	end

    def partner_params
      params.require(:user).permit(:email, :business_name, :category_id)
    end
end
