# == Schema Information
#
# Table name: requests
#
#  id         :integer          not null, primary key
#  date       :date
#  price      :decimal(, )
#  quantity   :float
#  symbol     :string(255)
#  user_id    :integer
#  club_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  message    :string(255)
#  status     :string(255)
#

class Request < ActiveRecord::Base
  # attr_accessible :title, :body
end
