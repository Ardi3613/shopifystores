class HomeController < ApplicationController
  def index
    @q = ShopifyStore.ransack(params[:q])
  end

  def terms
  end

  def privacy
  end

  def search_result
    @keywords = params[:q]
    @q = ShopifyStore.ransack(@keywords)
    @stores = @q.result(distinct: true)
  end

end
