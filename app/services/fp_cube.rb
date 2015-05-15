class FpCube
	def initialize(fpclass)
	 @fpclass = fpclass
	 @schedule = IceCube::Schedule.new(now = @fpclass.date) do |s|
     	s.add_recurrence_rule(IceCube::Rule.weekly)
     end
    end

    # Date should be "YYYY/MM/DD"
	def is_valid(date)
	  @schedule.occurs_on?(date)
	end

	#
	def between_dates
		@schedule.occurrences(@fpclass.expiry)
	end
end