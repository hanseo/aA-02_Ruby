require "byebug"

(1..100).each do |num|
  square = num ** 2
  half = num / 2.0
  debugger
end