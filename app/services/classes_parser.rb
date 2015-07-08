class ClassesParser

	## [TODO] :: 1) REJECT TODAY TIMINGS, PER_PAGE(2 TO 20)
	def initialize(fpclasses, date, page=0)
		@classes_in = fpclasses.blank? ? [] : fpclasses.to_a.uniq
		@classes_out = []
		@date = date
		@search_classes = []
		@page = page.to_i
	end

	def generate
		return [] if @classes_in.blank?  # Distinct gives error due to json for fpclass or somewhere
		
		@classes_in.each do |fpclass|
			@search_classes.concat get_search_classes(fpclass)
		end
		
		# sorting needs to be done
		@search_classes.sort { |x,y| x.time <=> y.time }
		@search_classes.in_groups_of(20, false)[@page].each do |search_clas|
			@classes_out << ClasParser.new(search_clas, @date)
		end

		@classes_out
	end

	def get_search_classes(fpclass)
		# reject{|time| Time.parse("#{@date} #{time}") < Time.now + 2.hours }
		fpclass.timings.collect do |time|
			SearchClas.new(time, fpclass)
		end
	end
end