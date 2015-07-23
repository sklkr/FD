#### Role ####
# Get fpclasses from redis server 

class ClasFetcher
	
	# Format :: date =  YYYY-MM-DD
	def initialize(date, fpids=[], opts={})
		@redis    = Redis.new
		@key_base = date.remove('-')
		@ids = fpids
		opts.reverse_merge!(
			start_time: 530,
			end_time: 2400
		)

		@options = opts
		@fpkeys = fpids_union
	end

	def fetch
		@redis.pipelined {
			@redis.multi do |multi|
				@fpkeys.reject{|key| !in_time(key) }.each do |id|
					multi.hgetall id
				end
			end
		}
	end

	def fpids_union
		parse_fpids.blank? ? [] : @redis.sunion(*parse_fpids)
	end

	def parse_fpids
		@ids.collect do |id|
			"#{@key_base}:#{id}"
		end
	end


	private
		def in_time(key)
			key = key.split(':')[2].to_i
			(@options[:start_time] <= key) && (key <= @options[:end_time])
		end
	# def inclass_time
	# 	key = rand(200..9999999).to_s + (65 + rand(26)).chr
	# 	values = @redis.zrangebyscore('time', @options[:start_time], @options[:end_time])
	# 	@redis.pipelined {
	# 		values.each {|val| @redis.sadd key, val}
	# 	}
	# 	key
	# end

	# Get fpclasses redis ids
	# def inclass_ids
	# 	#[TODO] : handle blank ids
	# 	@fpids.collect { |fpid| @redis.smembers fpid }.flatten
	# end

	
	# def inclass_date
	# 	@redis.smembers @date
	# end

	# ip :: [1,2,3,4,5]
	# op :: ['fpclass:1', 'fpclass:2', ....]
end