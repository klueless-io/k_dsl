# puts "STEP: Extend TrueClass / FalseClass"

# Extend the boolean class with some helper methods
class TrueClass
  def to_i
    return 1
  end

  def to_bool
    return self
  end

end

class FalseClass
  def to_i
    return 0
  end

  def to_bool
    return self
  end
end