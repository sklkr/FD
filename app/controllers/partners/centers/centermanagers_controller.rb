module Partners::Centers
class CentermanagersController < ApplicationController 
  before_filter :partner_authenticated?
  before_filter :partner_accessable?

  layout 'partnerdashboard'
  
  def index
    # Write code here !
    @centermanagers = center.centermen.includes(:user)
  end

  def new
  	@user = User.new
    @user.build_centerman
  end

  def create
    unless params['user']['password'] != params['user']['password_conf']
     user = User.new(params['user'].permit(:first_name, :phone, :address1, :address2, :password))
     if user.save && user.build_centerman(params['user']['centerman'].permit("email"))
      user.centerman.center_id = center.id
      if user.save
        flash[:notice] = "Centermanager Created Successfully"
        redirect_to partners_center_centermanagers_path
      end
     else
      render :new
     end
    else
     redirect_to new_partners_center_centermanager_path
    end
  end

  def edit
    @user = Centerman.find(params['id']).user
  end

  def update
    unless params['user']['password'] != params['user']['password_conf']
     user = Centerman.find(params['id']).user.update_attributes(params['user'].permit(:first_name, :phone, :address1, :address2, :password))
     redirect_to edit_partners_center_centermanager_path
    end
  end

  def destroy

  end
end
end