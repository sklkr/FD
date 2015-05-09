module Admins
class PartnersController < ApplicationController
	layout 'admin'
	before_filter :admin_authenticated?

	def list
		@partners = Partner.all.includes(:user)
	end

	def setpassword
		@partner = Partner.find(params[:id])
		@partner.user.update(:password => "fpadjko7542")
		respond_to do |format|
			format.js
		end
	end


	def index
		@centers = Center.unscoped.all.includes(:centerinfo, :city, :commission)
	end

	def show
		@bookings = Center.unscoped.find(params[:id]).bookings.includes(:customer)
	end

	def create
		# For FP Verification
		centers =  Center.unscoped.find(params['t1'].keys)
		unless params['fp'].nil?
			centers.each do |c|
				unless c.centerinfo.nil?
					c.centerinfo.update_attributes(:fp_verified => true)
				end
			end
		end

		unless params['history'].nil?
			return redirect_to admins_partner_path(centers.first.id)
		end

		unless params['approve'].nil?
			centers.each do |c|
				unless c.update_attributes(:status => 'active')
					return render :text => "Something went wrong"
				end
			end
		end

		# For commission
		unless params['commission'].nil?
			centers.each do |c|
				commission = Commission.find_or_create_by(:center_id => c.id)
				commission.val = params['commission_percent']
				commission.save
			end
		end

		unless params['send_email'].nil?
			centers.each do |c|
				AckMailer.atop(params['email_message'], c.partner.email).deliver
			end
		end

		unless params['send_sms'].nil?
			return render :text => 'sms api needs to be integrated'
		end
		
		redirect_to admins_partners_path
	end


end
end