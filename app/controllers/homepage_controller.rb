class HomepageController < ApplicationController
  before_action :to_search, :only => [:index]
  CENTERS = ["Contours -HSR ","Pink Fitness-HSR ","BDFA -HSR ","August Yoga -HSR ","MNC Swim -HSR ","Abhimanyu Boxing -HSR ","Hyper Monkey -Koramangala","Contours -Koramangala","Friends Yoga -Koramangala","Fitness One -Koramangala","Spedels ","Sam Boxing Club","BDFA - Koramangala","Answer is Fitness -Koramangala","Total Yoga -Koramangala","Aero Fitness ","Figurine Fitness -Koramangala","Contours -JayaNagar","Aayana Yoga -Jayanagar","Pink Fitness -Jayanagar","August Yoga -JPNagar","Figurine Fitness -JayaNagar","BDFA -JPNagar","Contours -Ulsoor","Steve Gym -Domlur","Fitness One -Domlur","Fit N Fine -Domlur","D'Cruze Dance ","Independent Shoot Fighter","Inchant Yoga ","Tarun Swimming  ","Sweat2B Fitness ","Figurine Fitness -Indiranagar","Vishwa Yoga -Indiranagar","Total Yoga -Indiranagar","Vishwa Yoga -HAL","Total Yoga -Whitefield","Figurine Fitness -BrookeField","O2 Health -Marathalli","Body & Soul Marathalli","Zero Lap Marathalli","Fitness Fanatics Marathalli","Answer is Fitness -Marathalli","Sastha Pool -Kundanhalli","Fitness One -SadashivaNagar","Stepperz -SadashivaNagar","Ramana Boxing -HRBRLayout","Stepperz -Kammanahalli","Figurine Fitness -KalyanNagar","Sastha Pool -Bellandur","BDFA -Sarjapur","BDFA -Banashankari","Coles Sports ","Total Yoga UBCity","BDFA -Bannarghatta","Raghavendra Yoga ","BDFA Mantri Residency","BDFA Kanakpura","Contours RTNagar","Contours JayaMahal","Phoenix Fitness ","Global Swim Center","Genesis","Apple Fitness","a1000 Yoga Indiranagar","a1000 Yoga Koramangala","a1000 Yoga  whitefield","a1000Yoga JPNagar","SnapFitness Marathalli","SnapFitnessMarathalli","The Tribe Indiranagar","SnapFitness Bellandur","SnapFitness Sarjapura","Apple Fitness HSR","HSR Fitness World","FIt Smart","Skanda Yoga","KlubFit","B3 Wellness","Zela Health Studio","Kyokushin Kan International","V S Fitness And Dance Studio","True Bounce Tennis academy","GoodLife Fitness Indiranagar","GoodLife Fitness Bellandur","Xtreme Muay Thai Academy"]
  def index
  	@categories = Category.all
  	@c = Center.ransack(params[:q])
    @centers = CENTERS
  end

  def centers_list
  	centers = {'Bengaluru' => CENTERS,
  	'chennai' => ["Pink Fitness -RAPuram","O2 Health Studio -Hadddow Road","Fitness One -Saligramam","Pink Fitness -Nanganallur","Contours India -Velachery","FitnessOne -Ambattur","FitnessOne -AnnaNagar","Pink Fitness -TNagar","136.1 Yoga -Sholinganallur","Pink Fitness -Pallikaranai","Pink Fitness -Velachery","Fitness One -Velachery","O2 health Studio -Ashok Nagar","Pink Fitness -Nolambur","Pink Fitness -Besant Nagar","Pink Fitness -Thiruvanmiyur","O2 health Studio -Nungambakkam","136.1 - Kilpauk","Pink Fitness -Nungambakkam","FitnessOne -Alwarpet","Pink Fitness -Valasaravalkkam","O2 Health studio- Besant Nagar","O2 Health Studio -velachery","O2 Health Studio -  Mogappair","Pink Fitness- Neelankarai","Pink Fitness - Selaiyar","136.1 Yoga - Alwarpet","FitnessOne - Kilpauk","Pink Fitness - Anna Nagar"], 'hyderabad' => ['Pink Fitness', 'Fitness One']}
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
