# == Schema Information
#
# Table name: clubs
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Club < ActiveRecord::Base
  has_many :deposits
  has_many :users, :through => :deposits
  has_many :transactions
  has_many :requests
  has_many :votes, :through => :requests

  def members
    self.users.uniq
  end

  def portfolio
    self.transactions.collect(&:symbol).uniq
  end


  def holdings
    holdings = {}
    self.transactions.each do |t|
      if holdings[t.symbol]
        holdings[t.symbol] += ( t.quantity * t.price )
      else
        holdings[t.symbol] = ( t.quantity * t.price )
      end
    end
    return holdings
  end
  # (start.to_date..Date.today).map do |date|
  #   {
  #     purchased_at: date,
  #     price: total_prices[date] || 0,
  #     shipping_price: shipping_prices[date] || 0,
  #     download_price: download_prices[date] || 0
  #   }
  # end


end
