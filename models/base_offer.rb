

class BaseOffer

<<<<<<< HEAD
  attr_accessor :id, :offer_id
=======
  attr_accessor :id, :offer_id, :datetime_expiration
>>>>>>> 3dd0e1ea9663b056fb5ae40158f18cf99a24cdab

  include ActiveModel::Model
  include ActiveModel::Validations
  extend ActiveModel::Callbacks
  define_model_callbacks :create

  before_create :set_ids, :set_expiration

  # class variables
  @@offers_counter = 0

  def initialize(hash)
    super(hash)
    create # Trigger create method to enable create callback
  end

  def create
    run_callbacks :create
  end


  private

  def set_ids
    self.id = @@offers_counter = @@offers_counter.next
    self.offer_id = Digest::MD5.hexdigest Time.now.to_s
  end

  def set_expiration
    self.datetime_expiration = Chronic.parse('in 24 hours')
  end



end
