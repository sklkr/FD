class PartnersController < ApplicationController
layout 'homepage'
  def index

  end

  def new
  	@partner = Partner.new
  	@partner.build_user
  	@partner.centers.build
  end

  def create
  	@partner = Partner.new(permit_params)
    @partner.centers.first.status = 'inactive'
  	if @partner.save
  		AcknowledgeMailer.partner_reg(@partner).deliver
  		redirect_to new_partner_path, :notice => "Thank you for showing interest as a FitnessPapa parter. We'll get back to you soon"
  	else
  		render 'new'
  	end
  end

  private
  	def permit_params
  		params.require(:partner).permit(:email, :partner_type, :user_attributes => [:full_name, :phone], :centers_attributes => [:name])
  	end
end
