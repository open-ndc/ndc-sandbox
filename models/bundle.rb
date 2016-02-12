class Bundle < ActiveRecord::Base
  has_and_belongs_to_many :fares
  has_and_belongs_to_many :services
  has_and_belongs_to_many :routes
end
