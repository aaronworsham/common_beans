class InviteFinancialAdvisersController < ApplicationController
  def gather
    if (@invite = FinancialAdviserInvite.find_by_token(params[:token]))
      flash[:success] = 'Success'
    else
      redirect_to root_path
    end
  end

  def redeem
    if (@invite = FinancialAdviserInvite.find_by_token(params[:user][:token]))
      if @invite.passcode.nil? or (@invite.passcode == params[:user][:passcode])
        u = User.create(params[:user])
        u.financial_clients << @invite.user
        u.save
      else
        redirect_to root_path
      end
    else
      redirect_to root_path
    end

  end
end
