#### Role ####
# Get Fitnesspapa classes from database on given date
# Push to Redis server

class ClasPusher
	
	attr_reader :fpclasses
	
	# Format :: date =  YYYY-MM-DD
	def initialize(date)
		@date = date
		@fpclasses = Fpclass.any_classes(date)
		@redis = Redis.new
		@key_base = date.remove('-')
	end

	def push
		return if @fpclasses.blank?
		@fpclasses.each do |fpclass|
			handler FpclassSerializer.new(fpclass)
		end
	end

	# Pushes individual fpclass to redis store
	def handler fpclass
		@redis.pipelined {
			fpclass.timings.each do |time|
				neat_time = time.remove(':')
				key = "#{@key_base}:#{fpclass.id}:#{neat_time}" #key => DATE:FPCLASSID:TIME
				unless @redis.hmset key, 'id', key ,'capname', fpclass.capname, 'class_path', fpclass.class_path, 'date', @date, 'time', time, 'duration', fpclass.duration, 'seats', fpclass.seats, 'place_name', fpclass.place_name, 'center_name', fpclass.center_name, 'center_slug', fpclass.center_slug, 'center_path', fpclass.center_path
					Rails.logger.error "key : #{key} not stored. Check once"
				end
				@redis.sadd "#{@key_base}:#{fpclass.id}", key  # To retrieve fpclasses on certain date later
			end	
		}
	end
end