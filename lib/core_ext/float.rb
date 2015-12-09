class Float

  def to_price(decimals = 2)
    "%.#{decimals}f" % self
  end

end
