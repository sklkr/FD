class HomepageController < ApplicationController
  before_action :to_search, :only => [:index]
  CENTERS = ["O2 Health Studio","Fitness One","Pink Fitness","Contours Inda","Zero Lap Fitness","Body and Soul Fitness","STEPPERZ","August Yoga","Independent Shoot Fighter","Coles Sports World","D'Cruze Dance Studio","Ramana Boxing","Sam Gym Boxing Studio","Abimanyu Kick Boxing","Sweat 2B Fit","Fit N Fine","Friends Yoga","Inchant Yoga","Aayana Yoga Academy","Spedels","Raghavendra Yoga","Tarun Swimming Center","Phoenix Fitness ","Sastha Pools","Global Swim Center","MNC Sports Academy","The Answer is Fitness","136.1 Yoga Studio","Fitness Cube","FunkyTown","Apple Fitness","GENESIS"]
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
