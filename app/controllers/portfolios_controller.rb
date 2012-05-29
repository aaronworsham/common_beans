class PortfoliosController < ApplicationController


  respond_to :html, :json

  def index
    @portfolios = current_user.portfolios
    respond_with(@portfolios)
  end

  def show
    @portfolio = current_user.portfolios.find_by_id params[:id]
    respond_with(@portfolio)
  end

  def create
    @portfolio = Portfolio.create(params[:portfolio].merge(:user => current_user))
    respond_with(@portfolio)
  rescue => e
    p e.message
    logger.error e.message
  end

  def destroy
    @portfolio = current_user.portfolios.find_by_id params[:id]
    @portfolio.destroy
    respond_with(@portfolio)
  end

  def compare
    @portfolio = current_user.portfolios.find_by_id params[:portfolio_id]
    if @portfolio
      respond_with(@portfolio.compare_indices)
    end
  end
end
