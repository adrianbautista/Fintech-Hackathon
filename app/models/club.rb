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


end
