class Calculator
  def initialize(val1=1,val2=1)
    @val1 = val1
    @val2 = val2
  end

  def add
    @val1 + @val2
  end

  def subtract
    @val1 - @val2
  end
end

calc = Calculator.new(20,11)
puts calc.add
puts calc.subtract