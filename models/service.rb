class Service < ActiveRecord::Base
  belongs_to :airline
  has_and_belongs_to_many :routes
  has_and_belongs_to_many :services_bundle
end
