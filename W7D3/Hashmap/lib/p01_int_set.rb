require 'byebug'

class MaxIntSet
  attr_accessor :store
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    if !is_valid?(num)
      raise "Out of bounds"
    end
    @store[num] = true 
    
  end

  def remove(num) 
    @store[num] = false
  end

  def include?(num)
    @store[num] == true
  end

  private

  def is_valid?(num)
    num < @store.length && num > -1
  end

  def validate!(num)
  end
end


class IntSet
  attr_accessor :store
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    i = num%20
    self.store[i] << num
  end

  def remove(num)
    i=num%20
    self.store[i].delete(num)
  end

  def include?(num)
     i=num%20
     self.store[i].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_accessor :count
  attr_accessor :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if count >= store.length
      resize!
    end
    i = num % store.length
    if !self.store[i].include?(num)
      self.store[i] << num  
      @count += 1
    end
  end

  def remove(num)
    i=num % store.length
    @count -= 1 unless self.store[i].delete(num).nil?
  end

  def include?(num)
    i=num % @store.length
    self.store[i].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    if count >= @store.length
      new_store = Array.new(store.length * 2) {Array.new}
      i = new_store.length
      @store.each do |bucket|
        bucket.each do |el|
          j = el % i
          new_store[j] << el
        end
      end
    end
    self.store = new_store
    

  end
end
