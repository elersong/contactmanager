class User < ActiveRecord::Base
  has_many :people
  has_many :companies
  
  def self.find_or_create_by_auth(data)
    if User.where(name: data['info']['name']) != []
      # Do nothing, because the array with the user records includes at least one user with this name already
      user = User.where(name: data['info']['name']).first
    else
      # If the hash is empty, then no users have registered this name/uid. 
      # It is safe to create a new User. 
      user = User.create(:provider => data['provider'], :uid => data['uid'], :name => data['info']['name'])
    end
    user
  end
  
end
