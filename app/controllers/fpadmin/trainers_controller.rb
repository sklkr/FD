## Admin Dashboard >> Trainers

module Fpadmin
class TrainersController < BaseController 
layout 'fpadmin'
before_filter :authenticated?

  def index
   @trainers = Trainer.all
  end

end
end