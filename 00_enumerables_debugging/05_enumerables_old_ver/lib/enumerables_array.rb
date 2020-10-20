require "byebug"

def factors(num)
  factors = []

  (1..num).each do |factor|
    if num % factor == 0
      factors << factor
    end
  end

  factors
end

def substrings(string)
  substr = []

  (0...string.length).each do |start_i|
    (start_i...string.length).each do |end_i|
      substr << string[start_i..end_i]
    end
  end

  substr.uniq
end

def subwords(word, dictionary)
  valid_words = []

  substrings(word).each do |ele|
    valid_words << ele if dictionary.include?(ele)
  end

  valid_words
end

def doubler(array)
  doubled = []

  array.each do |ele|
    doubled << ele * 2
  end

  doubled
end

def concatenate(strings)
  strings.inject(:+)
end

class Array
  def my_each(&prc)
    self.length.times do |i|
      prc.call(self[i])
    end

    self
  end

  def my_select(&prc)
    selects = []

    self.my_each do |ele|
      selects << ele if prc.call(ele)
    end

    selects
  end

  def my_reject(&prc)
    rejects = []

    self.my_each do |ele|
      rejects << ele if !prc.call(ele)
    end

    rejects
  end

  def my_map(&prc)
    mapped = []

    self.my_each do |ele|
      mapped << prc.call(ele)
    end

    mapped
  end

  def my_inject(&blk)
    acc = self[0]

    self.drop(1).my_each do |ele|
      acc = blk.call(acc, ele) 
    end

    acc
  end

  def my_any?(&prc)
    self.my_each do |ele|
      return true if prc.call(ele)
    end

    false
  end

  def my_all?(&prc)
    self.my_each do |ele|
      return false if !prc.call(ele)
    end

    true
  end

  def my_flatten
    flattened = []

    self.my_each do |ele|
      if ele.is_a?(Array)
        flattened.concat(ele.my_flatten)
      else
        flattened << ele
      end
    end

    flattened
  end

  def my_zip(*arrs)
    zipped = []

    self.length.times do |i|
      sub_zip = [self[i]]
      
      arrs.my_each do |arr|
        sub_zip << arr[i]
      end

      zipped << sub_zip
    end

    zipped
  end

  def my_rotate(position = 1)
    split_idx = position % self.length
    self.drop(split_idx) + self.take(split_idx)
  end

  def my_join(separator = "")
    joined = ""

    self.length.times do |i|
      joined += self[i]
      joined += separator unless i == self.length - 1
    end
    
    joined
  end

  def my_reverse
    reversed = []

    self.my_each do |ele|
      reversed.unshift(ele)
    end

    reversed
  end

  def bubble_sort!(&prc)
    sorted = false
    prc ||= Proc.new {|el_1, el_2| el_1 <=> el_2}

    while !sorted
      sorted = true

      (self.length - 1).times do |i|
        if prc.call(self[i], self[i + 1]) == 1
          self[i], self[i + 1] = self[i + 1], self[i]
          sorted = false
        end
      end
    end
    
    self
  end

  def bubble_sort(&prc)
    sorted = self.dup
    sorted.bubble_sort!(&prc)
  end
end


