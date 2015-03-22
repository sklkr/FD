class HomepageController < ApplicationController
  def index
  	@header = false # just to turnoff static black header 
  	@categories = Category.all
  end
end
