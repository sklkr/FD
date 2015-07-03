class FpConditioner

	def initialize(fpclass, cx)
	  @fpclass = fpclass
	  @context = cx
	  @passport = @context.passport
	  @clasbkings = @passport.clasbkings
  	end

	def active_space
	   @context.flash.alert = "You can only reserve upto 8 active classes."  unless @clasbkings.count < 10
	   @clasbkings.count < 10
	end

	def can_center
	   @context.flash.alert = "You can only reserve upto 3 maximum classes per center."  unless @fpclass.centers.first.clasbkings.count < 3
	   @fpclass.centers.first.clasbkings.count < 3
	end

	def date_not_exceeds_passport
		@context.flash.alert = "Booking date exceeds passport validity time period. Contact support to extend passport" unless @context.params[:date].to_date <= @passport.end_date
		@context.params[:date].to_date <= @passport.end_date
	end

	def is_he_eligible
		date_not_exceeds_passport && active_space && can_center
	end
end
