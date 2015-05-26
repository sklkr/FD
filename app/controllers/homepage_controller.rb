class HomepageController < ApplicationController
  before_action :to_search, :only => [:index]
  
  def index
  	@categories = Category.all
  	@c = Center.ransack(params[:q])
  end

  def centers_list
  	centers = {'Bengaluru' => ["Tarun Swimming Center","O2 Health Studio","Phoenix Fitness ","Sastha Pools","Global Swim Center","MNC Sports Academy","Fitness One ","Fitness One","Pink Fitness","The Answer is Fitness","Zero Lap Fitness","Fit Life Gym","STEPPERZ","136.1 Yoga Studio","August Yoga","Fitness Cube","FunkyTown","Apple Fitness","GENESIS","Contours Inda", "Friends Yoga", "Independent Shoot Fighter", "Coles Sports World", "Inchant Yoga", "Aayana Yoga Academy", "Spedels", "Sweat 2B Fit", "Fit N Fine", "Raghavendra Yoga", "D'Cruze Dance Studio", "Ramana Boxing", "Sam Gym Boxing Studio", "Abimanyu Kick Boxing Academy"],
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
