# == Schema Information
#
# Table name: transactions
#
#  id         :integer          not null, primary key
#  club_id    :integer
#  price      :decimal(, )
#  quantity   :float
#  symbol     :string(255)
#  date       :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Transaction < ActiveRecord::Base
  # attr_accessible :title, :body
end
