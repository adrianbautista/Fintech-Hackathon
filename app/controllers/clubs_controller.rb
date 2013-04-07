class ClubsController < ApplicationController

  def index
    @clubs = Club.order("created_at DESC")
  end

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
    @transaction = Transaction.new
    @transaction.club_id = @club.id
    @transaction.price = 1
    @transaction.quantity = params[:deposit][:amount]
    @transaction.symbol = "USD"
    @transaction.date = Date.today

    if @deposit.save && @transaction.save
      redirect_to user_path(current_user), notice: "Club #{@club.name} created!"
    else
      render 'new'
    end
  end

  def join



  end

  def show
    @club = Club.find(params[:id])
    @deposits = @club.deposits

    @total_invested = 0

    @deposits.each do |d|
      @total_invested += d.amount
    end

    @members = @deposits.collect(&:user).uniq

    @holdings = {}

    @club.transactions.each do |t|
      if @holdings[t.symbol]
        @holdings[t.symbol] += ( t.quantity * t.price )
      else
        @holdings[t.symbol] = ( t.quantity * t.price )
      end
    end
    # FIX THIS SHITS!!!
    @requests = @club.requests.where(: nil)
  end

end
