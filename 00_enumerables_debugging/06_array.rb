class Array
  def my_flatten
    flattened = []
    
    self.each do |el| 
      if el.is_a? Array
        flattened += el.my_flatten
      else
        flattened << el
      end  
    end
    flatten
  end

  def my_zip(*arrs)
    zipped = Array.new(self.length) { Array.new(*arrs.length + 1)}
    target_arr = [self]
    arrs.each { |arr| target_arr << arr }

    (0...self.length).each do |i_1|
      (0...arrs.length + 1).each do |i_2|
        zipped[i_1][i_2] = target_arr[i_2][i_1]
      end
    end

    zipped
  end

  def my_rotate(n = 1)
    return self if n == 0

    if n > 0
      first = self.shift
      self << first
      my_rotate(n - 1)
    else
      last = self.pop
      self.unshift(last)
      my_rotate(n + 1)
    end
  end

  def my_join(string = "")
    joined = ""
    self.length.times do |i| 
      joined += self[i]
      joined += string unless i == self.length - 1
    end

    joined
  end

  def my_reverse
    reversed = []
    (1..self.length).each do |i|
      reversed << self[-i]
    end

    reversed
  end
end

=begin
p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]

a = [ 4, 5, 6 ]
b = [ 7, 8, 9 ]
p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

c = [10, 11, 12]
d = [13, 14, 15]
p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]

a = [ "a", "b", "c", "d" ]
p a.my_rotate         #=> ["b", "c", "d", "a"]
p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
p a.my_rotate(15)     #=> ["d", "a", "b", "c"]

a = [ "a", "b", "c", "d" ]
p a.my_join         # => "abcd"
p a.my_join("$")    # => "a$b$c$d"

p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
p [ 1 ].my_reverse               #=> [1]
=end