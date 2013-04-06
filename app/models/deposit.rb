# == Schema Information
#
# Table name: deposits
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  club_id    :integer
#  amount     :decimal(, )
#  date       :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Deposit < ActiveRecord::Base
  belongs_to :user
  belongs_to :club
end
