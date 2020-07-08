require 'activerecord-import/base'
require 'csv'
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
    @total_stores = @q.result(distinct: true)
    @stores = @total_stores.page(params[:page]).per(25)
  end

  def import_form
  end

  def import_stores
    file = params[:file]
    stores = []
    CSV.foreach(file, headers: true) do |row|
      stores << ShopifyStore.new(row.to_h)
    end
    if ShopifyStore.import(stores)
      flash[:notice] = "#{stores.count} stores have been imported successfully"
    else
      flash[:alert] = 'an error occurred while importing cities'
    end
    redirect_to root_path
  end

end
