module Admins
class PartnersController < ApplicationController
	layout 'admin'
	def index
		@centers = Center.all.includes(:centerinfo, :city, :commission)
	end

	def show

	end

	def create
		# For FP Verification
		centers =  Center.find(params['t1'].keys)
		unless params['fp'].nil?
			centers.each do |c|
				unless c.centerinfo.nil?
					c.centerinfo.update_attributes(:fp_verified => true)
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