class HomepageController < ApplicationController
  def index
  	@header = false # just to turnoff static black header 
  	binding.pry
  end
end
