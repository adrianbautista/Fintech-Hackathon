# == Schema Information
#
# Table name: votes
#
#  id         :integer          not null, primary key
#  request_id :integer
#  user_id    :integer
#  club_id    :integer
#  value      :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Vote < ActiveRecord::Base
  attr_accessible :club_id, :request_id, :user_id, :value
  belongs_to :request
  belongs_to :user, :through => :request
end
