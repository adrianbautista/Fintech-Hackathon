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
    @user = current_user

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
    # @last_quote = YahooFinance::get_quotes(YahooFinance::StandardQuote, 'AAPL')['AAPL'].lastTrade

    @user = current_user
    @club = Club.find(params[:id])
    @deposits = @club.deposits
    @total_invested = 0
    @deposits.each do |d|
      @total_invested += d.amount
    end

    @members = @deposits.collect(&:user).uniq

    @holdings = []
    @club.holdings.each do |symbol, value|
      holding = {}
      holding[:label] = symbol
      holding[:value] = value.to_i
      @holdings << holding
    end

    @portfolio_list = []
    @portfolio_wo_USD1 = @club.portfolio
    @portfolio_wo_USD1.delete('USD')
    @portfolio_wo_USD1.each do |ticker|
      @portfolio_list << YahooFinance::get_quotes(YahooFinance::StandardQuote, ticker)[ticker].lastTrade
    end
    @begin = Transaction.where(club_id: @club.id).map(&:price)

    @percent = []
    count = 0
    @portfolio_list.each do |ending|
      start = @begin[count]
      @percent << ( (ending / start) - 1 )
      count += 1
    end
    @performance = (@percent.inject(0.0) { |sum, el| sum + el } / @percent.size) * 100


    # @pie=[@holdings]
    # @holdings.each do |h|
    #   @pie << h 
    # end

    @json = '#{@holdings}'

    # @portfolio_list = []
    # @portfolio_wo_USD = @club.portfolio
    # @portfolio_wo_USD.delete('USD')
    # @portfolio_wo_USD.each do |ticker|
    #   @portfolio_list << YahooFinance::get_quotes(YahooFinance::StandardQuote, ticker)[ticker].lastTrade
    # end

    # @portfolio_list = []
    # @portfolio_wo_USD1 = @club.portfolio
    # @portfolio_wo_USD1.delete('USD')
    # @portfolio_wo_USD1.each do |ticker|
    #   @portfolio_list << YahooFinance::get_quotes(YahooFinance::StandardQuote, ticker)[ticker].lastTrade
    # end
    # @begin = Transaction.where(club_id: @club.id).map(&:price)

    # @percent = []
    # count = 0
    # @portfolio_list.each do |ending|
    #   start = @begin[count]
    #   @percent << ( (ending / start) - 1 )
    #   count += 1
    # end


    # @members = @club.members

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

    # {"GOOG"=>5855.2, "AAPL"=>8548.2, "VMW"=>5160.0, "CTSH"=>2824.4, "USD"=>18612.2}

    # @big_graph = {}
    # @portfolio_wo_USD = @club.holdings
    # @portfolio_wo_USD.delete('USD')
    # @portfolio_wo_USD.each do |symbol, worth|
    #   equity = {}
    #   cash = {}
    #   YahooFinance::get_HistoricalQuotes_days( symbol.downcase, 30 ) do |hq|
    #     equity[hq.date] = hq.close
    #     cash[hq.date] = 1
    #   end
    #   @big_graph[symbol] = equity
    #   @big_graph['USD'] = cash
    # end

# Object.new(y: date, a: a, b: b, c: c, d: d, e: e)


@perf = []
    @big_graph = {}
    @portfolio_wo_USD = @club.holdings
    @portfolio_wo_USD.delete('USD')
    @portfolio_wo_USD.each do |symbol, worth|
      equity = {}
      cash = {}
      YahooFinance::get_HistoricalQuotes_days( symbol.downcase, 30 ) do |hq|
        equity[hq.date] = hq.close
        cash[hq.date] = 1
      end
      @big_graph[symbol] = equity
      @big_graph['USD'] = cash
    end

# k = symbol
# v = date/val graph_hash
# x = date
# y = value


@big_graph.each do |k,v|
  v.each do |x, y|
    @perf << "#{k}: #{y}"
  end
end


add = @perf.count / @club.holdings.count
perf_array = []
perf_string = ""
# add = 20
(0..add-1).each do |t|
  # @club.holdings.count = 5
  @club.holdings.count.times do |z|
    perf_string += "#{@perf[z*20+t]}, "
  end 

  perf_array << perf_string
  perf_string = ""
end

dates = []

@big_graph.each do |k,v|
  v.each do |x, y|
    dates << x
  end
end

i=0
dates.uniq.each do |x|
  perf_array[i].prepend("{ y: #{x}, ")
  perf_array[i] = perf_array[i][0..-3]
  perf_array[i] << " }"
  i+=1
end
  
@perf = perf_array.to_s.gsub('"',"")

# binding.pry

# perf_string = "perf[0] +', '+ @perf[20] +', '+ @perf[40] +', '+ @perf[60] + #{@perf[80]}"
  # data: [
  #   { y: '2006', a: 100, b: 90 },
  #   { y: '2007', a: 75,  b: 65 },
  #   { y: '2008', a: 50,  b: 40 },
  #   { y: '2009', a: 75,  b: 65 },
  #   { y: '2010', a: 50,  b: 40 },
  #   { y: '2011', a: 75,  b: 65 },
  #   { y: '2012', a: 100, b: 90 }
  # ],
  # xkey: 'y',
  # ykeys: ['a', 'b'],
  # labels: ['Series A', 'Series B']

    # xx = []
    # xx << 'a'<< 'b'<< 'c'<< 'd'<< 'e'
    # @perf = []
    # @big_graph.each do |symbol, h|

    #   h.each do |date, value|
    #     holding = {}
    #     holding[:y] = date
    #     xx.each do |z| 
    #       holding[z] = value.to_f
    #     end
    #     @perf << holding
    #   end
    #   xx.shift(1)
    # end

    # @perf = "#{@big_graph}"
  end
end
