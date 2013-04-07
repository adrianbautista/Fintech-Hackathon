# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable, 
         :rememberable, 
         :trackable, 
         :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, 
                  :password, 
                  :password_confirmation, 
                  :remember_me,
                  :provider,
                  :uid,
                  :image,
                  :name
  # attr_accessible :title, :body
  has_many :deposits
  has_many :clubs, :through => :deposits
  has_many :requests
  has_many :votes, :through => :requests

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(name:auth.extra.raw_info.name,
                           provider:auth.provider,
                           uid:auth.uid,
                           email:auth.info.email,
                           image: auth.info.image,
                           password:Devise.friendly_token[0,20]
                           )
    end
    user
  end


  def ownership(club)
    total_deposits = club.deposits.collect(&:amount).sum


    my_deposits = Deposit.where(user_id: id, club_id: club.id).collect(&:amount).sum  

    my_percent = (my_deposits / total_deposits) * 100

    return my_percent
  end  


  def total_deposits(club)
    my_deposits = Deposit.where(user_id: id, club_id: club.id).collect(&:amount).sum 
  end
end
