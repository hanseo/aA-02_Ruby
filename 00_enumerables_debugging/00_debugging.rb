require "byebug"
class Building
  def initialize
    @temperature = 70
  end

  def set_thermostat(temp)
    debugger if temp > 90
    @temperature = temp
  end
end

house = Building.new

# imagine this is called in one part of your program
house.set_thermostat(50 * 4 - 2 - 100 + -30)

# and here set_thermostat is set within some other distant class
house.set_thermostat(200 * 0.5 - 40 + 30 / 2)

# and who knows where this call to set_thermostat could be coming from
house.set_thermostat(100 / 3 + 80 - -30 + 3)