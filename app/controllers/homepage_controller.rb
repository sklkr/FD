class HomepageController < ApplicationController
  def index
  	binding.pry
  	@header = false # just to turnoff static black header 
  end
end
