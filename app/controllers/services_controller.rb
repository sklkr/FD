class ServicesController < CentersController
  before_filter :parse_category
  before_filter :assign_variables
  layout 'centers'

  def index
  	unless params['category_id'].nil?
      @services = center.services.regular.where('category_id=?',params[:cat_id])
      params[:id] = params[:center_id]
  	else
      render :text => 'something went wrong'
    end
  end

  private
    def parse_category
      params[:cat_id] = Category.find_lazy(params[:category_id]).try(:id)
    end
end
