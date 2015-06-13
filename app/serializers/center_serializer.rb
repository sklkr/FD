 class CenterSerializer < ActiveModel::Serializer
  attributes :id, :details_path, :image_path, :capname, :place_name, :detailed_desc

  def details_path
    "/details/#{object.slug}"
  end 

  def image_path
    "//d1djl7kr085bc1.cloudfront.net/store/#{object.image_id}"
  end

  def capname
    object.name.titleize
  end

  def detailed_desc
    object.centerinfo.detailed_desc
  end
end