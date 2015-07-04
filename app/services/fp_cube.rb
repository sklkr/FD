class FpCube
	def initialize(fpclass)
	 @fpclass = fpclass
	 @schedule = IceCube::Schedule.new(now = @fpclass.date) do |s|
     	s.add_recurrence_rule(IceCube::Rule.weekly(1).day(@fpclass.recurring['validations']['day'])) if  @fpclass.recurring['rule_type'] == "IceCube::WeeklyRule"
     end
    end

    # Date should be "YYYY/MM/DD"
	def is_valid(date)
	  @schedule.occurs_on?(date)
	end

	def rec_rule

	end

	#
	def between_dates
		@schedule.occurrences(@fpclass.expiry).collect {|date| date.to_date.to_s }
	end
end