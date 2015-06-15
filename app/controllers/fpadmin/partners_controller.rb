module Fpadmin
class PartnersController < BaseController 
layout 'fpadmin'

  def index
    @partners = Partner.recent.includes(:user).page params[:page]
  end

  def show

  end

  def destroy
  	@partner = Partner.find(params[:id])
  	if @partner.destroy
  		redirect_to :action => 'index'
  	else
  		render :text => 'something went wrong'
  	end
  end

  def activate
    @partner = Partner.find(params[:id])
    if @partner.user.update(:password => 'fpadjko7542', :active => 'true')
      redirect_to :action => 'index'
    else
      render :text => 'something went wrong'
    end

  end
end
end