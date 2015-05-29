module Admins
class ApprovalsController < ApplicationController
	layout 'admin'
	before_filter :admin_authenticated?

	def index
		@centers = Center.pending
	end

	def create
		centers =  Center.unscoped.find(params['t1'].keys)
		unless params['approve'].nil?
			centers.each do |c|
				unless c.update_attributes(:status => 'active')
					return render :text => "Something went wrong"
				end
			end
		end

		unless params['reject'].nil?
			centers.each do |c|
				unless c.update_attributes(:status => 'rejected')
					return render :text => "Something went wrong"
				end
			end
		end

		redirect_to admins_approvals_path, :notice => "Selected centers approved successfully"
	end
end
end
