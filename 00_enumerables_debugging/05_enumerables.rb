class Array
  def my_each(&prc)
    self.length.times { |i| prc.call(self[i]) }
    self
  end

  def my_select(&prc)
    selected = []

    self.my_each do |el|
      selected << el if prc.call(el)
    end

    selected
  end

  def my_reject(&prc)
    self - self.my_select(&prc)
  end

  def my_any?(&prc)
    self.my_select(&prc).length > 0
  end

  def my_all?(&prc)
    self.my_select(&prc).length == self.length
  end
end

=begin
return_value = [1, 2, 3].my_each do |num|
  puts num
end.my_each do |num|
  puts num
end

p return_value 

a = [1, 2, 3]
p a.my_select { |num| num > 1 } # => [2, 3]
p a.my_select { |num| num == 4 } # => []

a = [1, 2, 3]
p a.my_reject { |num| num > 1 } # => [1]
p a.my_reject { |num| num == 4 } # => [1, 2, 3]

a = [1, 2, 3]
p a.my_any? { |num| num > 1 } # => true
p a.my_any? { |num| num == 4 } # => false
p a.my_all? { |num| num > 1 } # => false
p a.my_all? { |num| num < 4 } # => true
=end