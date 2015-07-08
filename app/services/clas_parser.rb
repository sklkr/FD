class ClasParser
attr_reader :date, :time
	def initialize(search_clas, date)
		fpclass = search_clas.fpclass
		@fpclass = FpclassSerializer.new(fpclass).as_json['fpclass']
		@time = search_clas.time
		@date = Date.parse(date).strftime
		@key = "fpclass:#{fpclass.id}-#{date.remove('-')}#{@time.remove(':')}"
		@status = Redis.new.get @key
	end
end