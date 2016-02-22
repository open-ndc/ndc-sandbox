class ShoppingStore
  require "redis"

  def self.save_request(dep, arr, date_dep, token)
    hash = {"dep" => dep, "arr" => arr, "date_dep" => date_dep}
    Redis.current.set("airshopping-" + token, hash.to_json)
    Redis.current.expire("airshopping-" + token, 3000)
  end

  def self.get_request(response_id)
    if Redis.current.exists("airshopping-" + response_id)
      Redis.current.get("airshopping-" + response_id)
    else
      @errors << Errors::IvalidNDCMessageProcessing.new("Response ID not found")
      raise Errors::IvalidNDCMessageProcessing, "Response ID not found."
    end
  end

  def self.get_dow_hash(dep_date)
    # this method will return hash like this: { "mon" => true, "tue" => false ... so on }
    days = [ "mon", "tue", "wed", "thu", "fri", "sat", "sun" ]
    dow_hash = {}
    days.each do |day|
      if date_dep.strftime("%a").downcase == day
        dow_hash[day] = true
      else
        dow_hash[day] = false
      end
    end
  end
end
