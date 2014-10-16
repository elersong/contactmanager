class Person < ActiveRecord::Base
  validates  :first_name, :last_name, presence: true
  include Contact # Module to establish database relationships
  belongs_to :user
  
end
