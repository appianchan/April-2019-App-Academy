# Write a method that binary searches an array for a target and returns its
# index if found. Assume a sorted array.

# NB: YOU MUST WRITE THIS RECURSIVELY (searching half of the array every time).
# We will not give you points if you visit every element in the array every time
# you search.

# For example, given the array [1, 2, 3, 4], you should NOT be checking
# 1 first, then 2, then 3, then 4.
# require 'byebug'

def binary_search(arr, target)
  midpoint = arr.length/2
  return nil if arr == []
  return arr.length/2 if arr[midpoint] == target
  # debugger
  lower = arr[0...midpoint]
  upper = arr[midpoint + 1..-1]
  if target < arr[midpoint]
    binary_search(lower, target)
  else
    # return nil if binary_search(upper, target) == nil
    return nil if binary_search(upper,target) == nil
    binary_search(upper,target) + midpoint + 1
  end

end


class Array
  # Write a new `Array#pair_sum(target)` method that finds all pairs of
  # positions where the elements at those positions sum to the target.

  # NB: ordering matters. I want each of the pairs to be sorted
  # smaller index before bigger index. I want the array of pairs to be
  # sorted "dictionary-wise":
  #   [0, 2] before [1, 2] (smaller first elements come first)
  #   [0, 1] before [0, 2] (then smaller second elements come first)

  def pair_sum(target)
    final = []

    i = 0
    while i < self.length-1
      j = i + 1
      while j < self.length
        if self[i] + self[j] == target
          final << [i, j]
        end
        j += 1
      end
      i += 1
    end
    final

  end
end

# Write a method called 'sum_rec' that
# recursively calculates the sum of an array of values
def sum_rec(nums)
  return nums[0] if nums.length == 1
  return 0 if nums.empty?
  nums[0] + sum_rec(nums[1..-1])
end

class String
  # Write a method that finds all the unique substrings for a word

  def uniq_subs
    final = []

    i = 0
    while i < self.length
      j = i + 1
      while j <= self.length
        if !final.include?(self[i...j])
          final << self[i...j]
        end
        j += 1
      end
      i += 1
    end
    final
  end
end

def prime?(num)
  return false if num < 1
  return true if num == 2
  (2...num).each do |el|
    if num % el == 0
      return false
    end
  end
  return true
end

# Write a method that sums the first n prime numbers starting with 2.
def sum_n_primes(n)
  final = 0
  while n != 0
    (2...10000000000000000000000000000000000).each do |el|
      if prime?(el)
        final += el
        n -= 1
        if n == 0
          break
        end
      end
    end
    
  end
  final


end

class Array
  # Write a method that calls a passed block for each element of the array
  def my_each(&prc)
    i = 0
    while i < self.length
      prc.call(self[i])
      i += 1
    end
    self
  end
end

class Array
  # Write a method that calls a block for each element of the array
  # and returns a new array made up of the results
  def my_map(&prc)
    final = []
    self.each do |el|
      final << prc.call(el)
    end
    final
  end
end
