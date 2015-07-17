# Fitnesspapa homepage

class HomepageController < ApplicationController
  before_action :to_search, :only => [:index]
  # CENTERS = ["Contours -HSR ","Pink Fitness-HSR ","BDFA -HSR ","August Yoga -HSR ","MNC Swim -HSR ","Abhimanyu Boxing -HSR ","Hyper Monkey -Koramangala","Contours -Koramangala","Friends Yoga -Koramangala","Fitness One -Koramangala","Spedels ","Sam Boxing Club","BDFA - Koramangala","Answer is Fitness -Koramangala","Total Yoga -Koramangala","Aero Fitness ","Figurine Fitness -Koramangala","Contours -JayaNagar","Aayana Yoga -Jayanagar","Pink Fitness -Jayanagar","August Yoga -JPNagar","Figurine Fitness -JayaNagar","BDFA -JPNagar","Contours -Ulsoor","Steve Gym -Domlur","Fitness One -Domlur","Fit N Fine -Domlur","D'Cruze Dance ","Independent Shoot Fighter","Inchant Yoga ","Tarun Swimming  ","Sweat2B Fitness ","Figurine Fitness -Indiranagar","Vishwa Yoga -Indiranagar","Total Yoga -Indiranagar","Vishwa Yoga -HAL","Total Yoga -Whitefield","Figurine Fitness -BrookeField","O2 Health -Marathalli","Body & Soul Marathalli","Zero Lap Marathalli","Fitness Fanatics Marathalli","Answer is Fitness -Marathalli","Sastha Pool -Kundanhalli","Fitness One -SadashivaNagar","Stepperz -SadashivaNagar","Ramana Boxing -HRBRLayout","Stepperz -Kammanahalli","Figurine Fitness -KalyanNagar","Sastha Pool -Bellandur","BDFA -Sarjapur","BDFA -Banashankari","Coles Sports ","Total Yoga UBCity","BDFA -Bannarghatta","Raghavendra Yoga ","BDFA Mantri Residency","BDFA Kanakpura","Contours RTNagar","Contours JayaMahal","Phoenix Fitness ","Global Swim Center","Genesis","Apple Fitness","a1000 Yoga Indiranagar","a1000 Yoga Koramangala","a1000 Yoga  whitefield","a1000Yoga JPNagar","SnapFitness Marathalli","SnapFitnessMarathalli","The Tribe Indiranagar","SnapFitness Bellandur","SnapFitness Sarjapura","Apple Fitness HSR","HSR Fitness World","FIt Smart","Skanda Yoga","KlubFit","B3 Wellness","Zela Health Studio","Kyokushin Kan International","V S Fitness And Dance Studio","True Bounce Tennis academy","GoodLife Fitness Indiranagar","GoodLife Fitness Bellandur","Xtreme Muay Thai Academy"]
  def index
  	@categories = Category.all
  	@c = Center.ransack(params[:q])
    @centers = Center.all.includes(:centerinfo)
  end

  def centers_list
  	@map_centers = {:chennai => [13.042680, 80.230718], :bangalore => [12.971599, 77.594563]}
    @latitude = @map_centers[params[:city].to_sym][0]
    @longitude = @map_centers[params[:city].to_sym][1]
    respond_to do |format|
  		format.js
  	end
  end

  private
  	def to_search
  		redirect_to search_path unless current_user.nil?
  	end
end
