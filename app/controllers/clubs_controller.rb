class ClubsController < ApplicationController

  def new
    @club = Club.new
    @deposit = Deposit.new
  end

  def create
    @club = Club.create(name: params[:club][:name])
    @deposit = Deposit.new(amount: params[:deposit][:amount])
    @deposit.user_id = current_user.id
    @deposit.club_id = @club.id
    @deposit.date = Date.today
    
    if @deposit.save
      redirect_to root_path, notice: "Awesome!"
    else
      render 'new'
    end
  end

  def show

  end

end
