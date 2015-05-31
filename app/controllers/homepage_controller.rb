class HomepageController < ApplicationController
  before_action :to_search, :only => [:index]
  CENTERS = ["Contours -HSR ","Pink Fitness-HSR ","BDFA -HSR ","August Yoga -HSR ","MNC Swim -HSR ","Abhimanyu Boxing -HSR ","Contours -Koramangala","Friends Yoga -Koramangala","Fitness One -Koramangala","Spedels ","Sam Boxing Club","BDFA - Koramangala","Answer is Fitness -Koramangala","Total Yoga -Koramangala","Aero Fitness ","Figurine Fitness -Koramangala","Contours -JayaNagar","Aayana Yoga -Jayanagar","Pink Fitness -Jayanagar","August Yoga -JPNagar","Figurine Fitness -JayaNagar","BDFA -JPNagar","Contours -Ulsoor","Steve Gym -Domlur","Fitness One -Domlur","Fit N Fine -Domlur","D'Cruze Dance ","Independent Shoot Fighter","Inchant Yoga ","Tarun Swimming  ","Sweat2B Fitness ","Figurine Fitness -Indiranagar","Vishwa Yoga -Indiranagar","Total Yoga -Indiranagar","Vishwa Yoga -HAL","Total Yoga -Whitefield","Figurine Fitness -BrookeField","O2 Health -Marathalli","Body & Soul Marathalli","Zero Lap Marathalli","Fitness Fanatics Marathalli","Answer is Fitness -Marathalli","Sastha Pool -Kundanhalli","Fitness One -SadashivaNagar","Stepperz -SadashivaNagar","Ramana Boxing -HRBRLayout","Stepperz -Kammanahalli","Figurine Fitness -KalyanNagar","Sastha Pool -Bellandur","BDFA -Sarjapur","BDFA -Banashankari","Coles Sports ","Total Yoga UBCity","BDFA -Bannarghatta","Raghavendra Yoga ","BDFA Mantri Residency","BDFA Kanakpura","Contours RTNagar","Contours JayaMahal","Pheonix Fitness ","Global Swim Center","Genesis","Apple Fitness"]
  def index
  	@categories = Category.all
  	@c = Center.ransack(params[:q])
    @centers = CENTERS
  end

  def centers_list
  	centers = {'Bengaluru' => CENTERS,
  	'chennai' => ['O2 Health Studio', "Fitness One", "Pink Fitness", "Contours India", "136.1 Yoga"], 'hyderabad' => ['Pink Fitness', 'Fitness One']}
  	@centers = centers[params['city']] 
    params[:q] = {}
    params[:q][:center_place_name_cont_any] = params['city']
    @locations = Centerinfo.ransack(params[:q]).result.pluck(:latitude, :longitude)
  	respond_to do |format|
  		format.js
  	end
  end

  private
  	def to_search
  		redirect_to search_path unless current_user.nil?
  	end
end
