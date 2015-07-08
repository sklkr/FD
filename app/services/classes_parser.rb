class ClassesParser
	def initialize(fpclasses, date)
		@classes_in = fpclasses.blank? ? [] : fpclasses.to_a.uniq
		@classes_out = []
		@date = date
	end

	def generate
		return [] if @classes_in.blank?  # Distinct gives error due to json for fpclass or somewhere
		
		@classes_in.each do |fpclass|
			@classes_out.concat shows(fpclass)
		end

		@classes_out.sort! {|x, y| x.time.remove(':').to_i <=> y.time.remove(':').to_i }
	end

	def shows(fpclass)
		fpclass.timings.collect do |time|
			ClasParser.new(fpclass, time, @date)
		end
	end
end