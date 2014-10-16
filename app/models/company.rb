class Company < ActiveRecord::Base
  validates :name, presence: true
  include Contact # Module to establish database relationships
  belongs_to :user
end
