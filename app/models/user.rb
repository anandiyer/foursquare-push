class User < ActiveRecord::Base
  belongs_to :checkin
  
  def self.create_with_omniauth(auth)  
    create! do |user|  
      user.provider = auth["provider"]  
      user.uid = auth["uid"]  
      user.name = auth["user_info"]["name"]  
      user.phone = auth["user_info"]["phone"]
    end  
  end
end
