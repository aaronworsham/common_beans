class PortfoliosController < ApplicationController
  respond_to :html, :json

  def index
    @portfolios = current_user.portfolios
    respond_with(@portfolios)
  end

  def show
    @portfolio = Portfolio.find_by_id params[:id]
    respond_with(@portfolio)
  end

  def create
    @portfolio = Portfolio.create(params[:portfolio].merge(:user => current_user))
    respond_with(@portfolio)
  end

  def destroy
    @portfolio = Portfolio.find_by_id params[:id]
    @portfolio.destroy
    respond_with(@portfolio)
  end
end
