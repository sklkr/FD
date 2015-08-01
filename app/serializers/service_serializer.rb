class ServiceSerializer < ActiveModel::Serializer
  attributes :id, :name, :duration, :center_type, :selling_price, :place_name, :slug, :center_name, :center_path

  def center_name
  	object.center.name
  end

  def center_type
    object.center.center_type
  end

  def place_name
  	object.center.place_name
  end

  def center_path
   "/details/#{object.center.slug}"
  end
end
