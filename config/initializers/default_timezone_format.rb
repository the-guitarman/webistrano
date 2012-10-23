class Time
  def as_json(options = {})
    self.to_i*1000 + self.utc_offset*1000
  end
end