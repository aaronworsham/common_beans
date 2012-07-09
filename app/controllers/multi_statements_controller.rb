class MultiStatementsController < ApplicationController
  respond_to :html, :json

  def index
    @statements = current_user.multi_statements
    respond_with(@statements)
  end

  def show
    @statement = MultiHolding.find_by_id params[:id]
    respond_with(@statement)
  end

  def create
    @statement = MultiStatement.create(params[:multi_statement].merge(:user => current_user))
    respond_with(@statement)
  end
  def destroy
    @statement = MultiStatement.find_by_id params[:id]
    @statement.destroy
    respond_with(@statement)
  end
end
