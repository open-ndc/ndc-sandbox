class ShoppingStore
  require "redis"

  def self.save_request(dep, arr, date_dep)
    hash = {"dep" => dep, "arr" => arr, "date_dep" => date_dep}
    Redis.current.set("airshopping-" + @token, hash.to_json)
    Redis.current.expire("airshopping-" + @token, 3000)
  end

  def self.get_request(response_id)
    if Redis.current.exists("airshopping-" + response_id)
      Redis.current.get("airshopping-" + response_id)
    else
      @errors << Errors::IvalidNDCMessageProcessing.new("Response ID not found")
      raise Errors::IvalidNDCMessageProcessing, "Response ID not found."
    end
  end
end
