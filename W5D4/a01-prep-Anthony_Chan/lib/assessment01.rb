require 'byebug'
class Array

  # Monkey patch the Array class and add a my_inject method. If my_inject receives
  # no argument, then use the first element of the array as the default accumulator.

  def my_inject(accumulator = nil, &prc)
    

    if accumulator == nil
      accumulator = self[0]
      i = 1
      while i < self.length
        accumulator = prc.call(accumulator, self[i])
        i += 1
      end
    else
      i = 0
      while i < self.length
        accumulator = prc.call(accumulator, self[i]) 
        i += 1
      end
      
    end
    accumulator
  end
end

# primes(num) returns an array of the first "num" primes.
# You may wish to use an is_prime? helper method.

def is_prime?(num)
  return false if num < 2
  return true if num == 2 
  (2...num).each do |el|
    if num % el == 0
      return false
    end
  end
  true
end

def primes(num)
  final = []
  j = 2
  i = num
  while i > 0
    if is_prime?(j)
      final << j
      i-=1
    end
    j+= 1
  end
  final
end

# Write a recursive method that returns the first "num" factorial numbers.
# Note that the 1st factorial number is 0!, which equals 1. The 2nd factorial
# is 1!, the 3rd factorial is 2!, etc.

def factorials_rec(num)
  return [1] if num == 1
  return [1,1] if num == 2
  lol = factorials_rec(num - 1)
  next_num = lol[-1] * (num - 1)
  lol + [next_num]

end

class Array

  # Write an Array#dups method that will return a hash containing the indices of all
  # duplicate elements. The keys are the duplicate elements; the values are
  # arrays of their indices in ascending order, e.g.
  # [1, 3, 4, 3, 0, 3, 0].dups => { 3 => [1, 3, 5], 0 => [4, 6] }

  def dups
    hash = Hash.new(0)
    self.each_with_index do |el, i|
      if hash[el].is_a?(Array)
        hash[el] << i
      else
        hash[el] = [i]
      end
    end

    new_hash = Hash.new(0)
    hash.each do |k, v|
      if v.length > 1
        new_hash[k] = hash[k]
      end
    end
    new_hash

  end
end

class String

  # Write a String#symmetric_substrings method that returns an array of substrings
  # that are palindromes, e.g. "cool".symmetric_substrings => ["oo"]
  # Only include substrings of length > 1.

  def symmetric_substrings
    substrings = []
    i = 0
    while i < self.length
      j = i + 1
      while j <= self.length
        substrings << self[i...j]

        j += 1
      end
      i+=1
    end
    
    final = []
    substrings.each do |el|
      if el == el.reverse && el.length != 1
        final << el
      end
    end
    final
  end

end

class Array

  # Write an Array#merge_sort method; it should not modify the original array.

  def merge_sort(&prc)
    return self if self.length <= 1

    midpoint = self.length / 2
    upper = self[midpoint..-1].merge_sort(&prc)
    lower = self[0...midpoint].merge_sort(&prc)

    Array.merge(lower, upper, &prc)
  end

  private
  def self.merge(left, right, &prc)
    prc ||= Proc.new{|a, b| a <=> b}
    final = []
    until left.empty? || right.empty?
      final << (prc.call(left[0], right[0]) == 1 ? right.shift : left.shift)
    end
    final + left + right
  end
end
