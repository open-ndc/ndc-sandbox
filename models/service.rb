class Service < ActiveRecord::Base
  require "redis"
  belongs_to :airline
  has_and_belongs_to_many :routes
end
