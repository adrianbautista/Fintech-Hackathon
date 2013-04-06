class DepositsController < ApplicationController
  
  def new
    @user = current_user
    @club = Club.find(params[:club_id])
  end

  def create
    @deposit = Deposit.new
    
  end
  
end
