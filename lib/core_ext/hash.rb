class Hash

  def stringify_keys
    transform_keys{ |key| key.to_s }
  end

  def transform_keys
    result = {}
    each_key do |key|
      result[yield(key)] = self[key]
    end
    result
  end
  
end
