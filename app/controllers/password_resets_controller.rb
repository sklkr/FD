class PasswordResetsController < ApplicationController
  def new
  end

  def create
    unless params[:partner].nil?
      role = Partner.find_by_email(params[:email])
    else
      role = Customer.find_by_email(params[:email])
    end
    role.user.send_password_reset(role) if role
    redirect_to root_url, :notice => "Email sent with password reset instructions."
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Password reset has expired."
    elsif @user.update_attributes(params.require(:user).permit(:password))
      redirect_to root_url, :notice => "Password has been reset!"
    else
      render :edit
    end
  end

  def show
  end

  def change_password
    @user = current_user
  end

  def update_password
    if current_user.password == params['current_password'] && params['password'] == params['password_confirmation']
      current_user.password= params['password']
      redirect_to customers_details_path if current_user.save
    else
      flash["notice"] = "Please check your password provided"
      redirect_to customer_change_password_path
    end
  end
end
