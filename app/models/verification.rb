class Verification < ActiveRecord::Base
	attachment :pan, extension: ["pdf", 'jpg', 'jpeg']
	attachment :tax, extension: ["pdf", 'jpg', 'jpeg']
	attachment :address, extension: ["pdf", 'jpg', 'jpeg']
	attachment :tan, extension: ["pdf", 'jpg', 'jpeg']
	belongs_to :center
end
