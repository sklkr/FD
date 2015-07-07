class ClasParser
attr_reader :date, :time
	def initialize(fpclass, time, date)
		@fpclass = FpclassSerializer.new(fpclass).as_json['fpclass']
		@time = time
		@date = Date.parse(date).strftime
		@key = "fpclass:#{fpclass.id}-#{date.remove('-')}#{@time.remove(':')}"
		@status = Redis.new.get @key
	end
end