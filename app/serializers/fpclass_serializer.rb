class FpclassSerializer < ActiveModel::Serializer
  attributes :id, :capname, :start_time, :class_path, :duration, :remaining_seats, :place_name, :center_name, :center_slug, :center_path
  
  def capname
 	object.name.capitalize
  end

  def place_name
  	centers.place_name
  end

  def center_slug
  	centers.slug
  end

  def centers
  	object.centers.first
  end

  def center_path
	"/details/#{centers.slug}"
  end

  def center_name
    centers.name.capitalize
  end

  def class_path
    "/reserves/#{object.slug}"
  end
end