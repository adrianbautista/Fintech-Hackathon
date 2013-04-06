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

require 'spec_helper'

describe Transaction do
  pending "add some examples to (or delete) #{__FILE__}"
end
