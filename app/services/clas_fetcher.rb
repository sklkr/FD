#### Role ####
# Get fpclasses from redis server 

class ClasFetcher
	
	# Format :: date =  YYYY-MM-DD
	def initialize(date, fpids=[], opts={})
		@redis   = Redis.new
		@date    = date.remove('-')
		@fpids = fpids
		@fpkeys = @fpids.blank? ? [] : fpids_union # o/p :: list of keys ['fpclass:1', 'fpclass:2' ...]
		
		opts.reverse_merge!(
			start_time: 630,
			end_time: 2400
		)
		@options = opts
		@fptimekeys = inclass_time
		@ids = total_intersects # List of keys includes fpclass, date
	end

	def fetch
		@redis.pipelined {
			@ids.collect do |id|
				@redis.hgetall id
			end	
		}
		
	end

	def total_intersects
		@redis.sinter @date, @fpkeys, @fptimekeys
	end

	def fpids_union
		key = rand(200..9999999).to_s + (65 + rand(26)).chr
		values = @redis.sunion *parse_fpids
		values.each {|val| @redis.sadd key, val }
		key
	end

	def inclass_time
		key = rand(200..9999999).to_s + (65 + rand(26)).chr
		values = @redis.zrangebyscore('time', @options[:start_time], @options[:end_time])
		@redis.pipelined {
			values.each {|val| @redis.sadd key, val}
		}
		key
	end

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
	def parse_fpids
		@fpids.collect do |fpid|
			"fpclass:#{fpid}"
		end
	end
end