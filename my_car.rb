module Haulable
  def can_haul?(rank)
    rank >= 3
  end
end

class Vehicle
  attr_accessor :color
  attr_reader :year, :model

  @@number_of_vehicles = 0

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @@number_of_vehicles += 1
    @speed = 0
  end

  def accelerate(number)
    @speed += number
  end

  def brake(number)
    @speed -= number
  end

  def shut_off
    @speed = 0
  end

  def spray_paint(new_color)
    self.color = new_color
  end

  def self.gas_mileage(miles, gallons)
    puts miles / gallons
  end

  def current_speed
    puts @speed
  end

  def self.number_of_vehicles
    puts @@number_of_vehicles
  end

  def age
    puts "This truck is #{years} years old"
  end

  private

  def years
    Time.now.year - year
  end
end

# Car class inherits Vehicle.
class MyCar < Vehicle
  ACCENT = 'Racing Stripes'.freeze

  def to_s
    "This #{color} #{model} car is faaaaaast"
  end
end

# Truck class inherits Vehicle.
class MyTruck < Vehicle
  WHEELS = 18

  def wheels
    puts "This has #{WHEELS} wheels"
  end
end
