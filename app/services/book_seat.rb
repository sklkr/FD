class BookSeat
  def initialize(expired_at, fpclass)
    @name = "fpclass:#{fpclass.id}-#{expired_at.strftime("%y%m%d%H%M")}"
    @redis = Redis.new
  end

  def incrementor
    @redis.incr @name
  end

  def confirm
    @redis.get(@name).nil? ? class_initializer : incrementor
  end

  def cancel
    # Decrements the number stored at key by one. If the key does not exist, it is set to 0
    @redis.decr @name
  end

  def class_initializer
    @redis.set @name, 1
  end
 
end