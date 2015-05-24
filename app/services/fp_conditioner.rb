class FpConditioner
	def initialize(fpclass, passport)
	 @fpclass = fpclass
	 @passport = passport
	 @clasbkings = @passport.clasbkings
    end

	def active_full
	    @clasbkings.count >= 8
	end

	def center_full
	    @fpclass.centers.first.clasbkings.count >= 3
	end

	def is_he_eligible
		!active_full && !center_full
	end
end
