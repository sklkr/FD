module DetailsHelper

	def icon_fetcher(name)
		case name
		when "Two Wheeler"
			'fa fa-motorcycle'
		when "Four Wheeler"
			'fa fa-car'
		when "Air Conditioning"
			'fa fa-exclamation'
		when "Rest Room"
			'fa fa-bed'
		when "Locker" 
			'fa fa-key'
		when "Change Room"
			'fa fa-male'
		when "Wifi" 
			'fa fa-wifi'
		when "Shower" 
			'fa fa-eye'
		when "Swimming Pool"
			'flaticon-swimming20'
		when "Kids Play Area"
			'fa fa-exclamation'
		when "Steam & Sauna"
			'fa fa-exclamation'
		else
			"fa fa-exclamation"
		end
	end
end
