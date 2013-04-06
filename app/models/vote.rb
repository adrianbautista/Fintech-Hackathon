class Vote < ActiveRecord::Base
  attr_accessible :club_id, :request_id, :user_id, :value
end
