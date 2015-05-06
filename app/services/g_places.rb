class GPlaces
 def initialize(place)
    @key = "AIzaSyAs4tO9vd5JNhXOX8h492hEwfstspyTQAw"
    @place = place
    @client = GooglePlaces::Client.new(@key)
  end

  def get_id
    data.place_id
  end

  def data 
    @client.spots_by_query(@place).first
  end

end