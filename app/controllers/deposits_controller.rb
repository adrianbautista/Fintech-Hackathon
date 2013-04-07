class DepositsController < ApplicationController

  def new
    @user = current_user
    @club = Club.find(params[:club_id])
  end

  def create
    @user = current_user
    @club = Club.find(params[:club_id])
    @deposit = Deposit.new(amount: params[:amount])
    @deposit.user_id = current_user.id
    @deposit.club_id = @club.id
    @deposit.date = Date.today
    @transaction = Transaction.new
    @transaction.club_id = @club.id
    @transaction.price = 1
    @transaction.quantity = params[:amount]
    @transaction.symbol = "USD"
    @transaction.date = Date.today

    if @deposit.save && @transaction.save
      redirect_to club_path(@club), notice: "Deposit added!"
    else
      redirect_to club_path(@club), notice: "Deposit failed!"
    end
  end

end
