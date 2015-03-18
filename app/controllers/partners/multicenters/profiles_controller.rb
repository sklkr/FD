module Partners::Multicenters
  class ProfilesController < MulticentersController 
  layout 'partnerdashboard'
  before_filter :partner_authenticated?

    def index
    end

    def new
      
    end

  end
end