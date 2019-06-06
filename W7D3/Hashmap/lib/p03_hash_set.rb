class HashSet
  attr_reader :count
  attr_accessor :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    # hash = Hash.new(0)
    # hash[key] = key.hash
    if count >= store.length
      resize!
    end
    i = key.hash % store.length
    if !self.store[i].include?(key)
      self.store[i] << key
      @count += 1
    end
  end

  def include?(key)
    i=key.hash % @store.length
    self.store[i].include?(key)
  end

  def remove(key)
    i=key.hash % store.length
    @count -= 1 unless self.store[i].delete(key).nil?
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
      new_store = store
      @count = 0 
      self.store = Array.new(store.length * 2) {Array.new}
      i = self.store.length
      new_store.each do |bucket|
        bucket.each do |el| 
          self.insert(el)
        end
      end
    end
    
  end
end
