require_relative 'p04_linked_list'

class HashMap
  attr_accessor :count, :store
  include Enumerable
  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    i=key.hash % @store.length
    self.store[i].include?(key)
  end

  def set(key, val)
    if count >= store.length
      resize!
    end
    i = key.hash % store.length
    if !self.store[i].include?(key)
      self.store[i].append(key, val)
      @count += 1
    else
      self.store[i].update(key, val)
    end
  end

  def get(key)
    i = key.hash % store.length
    @store[i].get(key)
  end

  def delete(key)
     i=key.hash % store.length
    @count -= 1 if !self.store[i].remove(key).nil?
  end

  def each
    
    #p = Proc.new{|node| [node.key, node.val] }
    self.store.each do |bucket|
      bucket.each{|node| yield [node.key, node.val] }

    end
    #print final
    
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    if count >= @store.length
      new_store = store
      @count = 0
      self.store = Array.new(store.length * 2) {LinkedList.new}
      i = self.store.length
      new_store.each do |bucket|
        bucket.each do |node| 
          self.set(node.key, node.val)
        end
      end
    end
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
