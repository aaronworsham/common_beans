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
    params[:multi_statement][:started_on] = Date.strptime(params[:multi_statement][:started_on], '%m/%d/%Y')
    params[:multi_statement][:ended_on] = Date.strptime(params[:multi_statement][:ended_on], '%m/%d/%Y')
    @statement = MultiStatement.create(params[:multi_statement].merge(:user => current_user))
    respond_with(@statement)
  end
  def destroy
    @statement = MultiStatement.find_by_id params[:id]
    @statement.destroy
    respond_with(@statement)
  end
end
