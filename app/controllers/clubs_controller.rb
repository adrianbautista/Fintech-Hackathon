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
    @user = User.where(name: current_user.name).order("created_at").first

    @deposit.user_id = @user.id
    @deposit.club_id = @club.id
    @deposit.date = Date.today
    @transaction = Transaction.new
    @transaction.club_id = @club.id
    @transaction.price = 1
    @transaction.quantity = params[:deposit][:amount]
    @transaction.symbol = "USD"
    @transaction.date = Date.today

    if @deposit.save && @transaction.save
      redirect_to club_path(@club), notice: "Club #{@club.name} created!"
    else
      render 'new'
    end
  end

  def join
  end

  def show
    @user = User.where(name: current_user.name).order("created_at").first
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
    @votes = @club.votes.where(:club_id => @club.id).where(:value => nil).where(:user_id => current_user.id)
    # @graph_hash = {}
    # @portfolio_wo_USD = @club.portfolio
    # @portfolio_wo_USD.delete('USD')
    # @portfolio_wo_USD.each do |ticker|
    #   response = HTTParty.get("http://api.estimize.com/companies/#{ticker}/releases/2012.json",
    #     :headers => { "X-Estimize-Key" => "bc6edcf551938a889850525e" })
    #   @graph_hash[ticker.to_sym] = []
    #   response.each do |info|
    #     { year: info[:fiscal_year],
    #       quarter: info[:fiscal_quarter],
    #       eps: info[:eps],
    #       revenue: info[:revenue],
    #       con_rev: info[:consensus_revenue_estimate],
    #       con_eps: info[:consensus_eps_estimate],
    #       wall_rev: info[:wallstreet_revenue_estimate],
    #       wall_eps: info[:wallstreet_eps_estimate] }
    #     @graph_hash[ticker.to_sym] << info
    #   end
    # end
  end
end
