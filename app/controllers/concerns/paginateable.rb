module Paginateable
  def pagination_params
    limit = params[:limit]? Integer(params[:limit]) : 20
    page = params[:page]? Integer(params[:page]) : 1
    offset = (page - 1) * limit

    return limit, page, offset
  end

  def create_pagination_object(limit:, page:, count:, data:)
    last_page = (count + limit - 1) / limit # Integer ceiling

    pagination_object = {
      current_page: page,
      last_page: last_page,
      limit: limit,
      total: count,
      data: data
    }
  end
end