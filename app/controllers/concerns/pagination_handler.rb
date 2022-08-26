module PaginationHandler
  extend ActiveSupport::Concern

  class PaginationError < StandardError; end

  def pagination_params
    limit = params[:per_page].to_i
    
    if limit > 100
      raise PaginationError, "The per_page parameter can't be more than 100"
    end
    
    page_number = params[:page].to_i
    offset = (page_number * limit) - limit

    [limit, offset]
  end
end
