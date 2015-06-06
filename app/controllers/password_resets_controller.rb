class PasswordResetsController < ApplicationController
layout 'homepage'
before_action :authenticated?, only: [:change_password, :update_password]

  def new

  end

  def create
    unless params[:partner].nil?
      role = Partner.find_by_email(params[:email])
    else
      role = Customer.find_by_email(params[:email])
    end
    role.send_password_reset(role) if role
    flash[:notice] = "Reset instructions sent to mail if email exists with FitnessPapa..!"
    render :new
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
    if current_user.crypted_password && current_user.password == params['user']['current_password'] && params['user']['password'] == params['user']['password_confirmation']
      current_user.password= params['user']['password']
      flash[:notice] = "Password changed successfully"
      redirect_to root_url if current_user.save
    else
      flash["alert"] = "Please check your credentails once"
      @user = current_user
      render 'change_password'
    end
  end
end
