class IndicesController < ApplicationController
  respond_to :json
  def show
    @index = Index.find_by_symbol(params[:id].upcase)
    respond_with(@index)
  end
end
