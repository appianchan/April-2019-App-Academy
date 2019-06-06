class Node

  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable
  attr_accessor :head, :tail
  def initialize
    @head= Node.new()
    @tail = Node.new()
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
     @head.next == @tail
  end

  def get(key)
    node_temp = @head.next
    until node_temp == @tail
       if node_temp.key == key
        return node_temp.val
       end
       node_temp = node_temp.next
    end
    nil
  end

  def include?(key)
    node_temp = @head.next
    until node_temp == @tail
       if node_temp.key == key
        return true
       end
       node_temp = node_temp.next
    end
    false
  end

  def append(key, val)
    node_add = Node.new(key, val)
    @tail.prev.next = node_add
    node_add.prev = @tail.prev
    @tail.prev = node_add
    node_add.next = @tail
  end

  def update(key, val)
    node_temp = @head.next
    until node_temp == @tail
       if node_temp.key == key
          node_temp.val = val
          return
       end
       node_temp = node_temp.next
    end
  end

  def remove(key)
    node_temp = @head.next
    until node_temp == @tail
       if node_temp.key == key
          node_temp.prev.next = node_temp.next
          node_temp.next.prev = node_temp.prev 
          return true
       end
       node_temp = node_temp.next
    end
    nil 
  end

  def each(&prc)
    # final = []
    prc||= Proc.new{|node| node.val }
    node_temp = @head.next
    until node_temp == @tail
      prc.call(node_temp)
     #yield(node_temp)
     node_temp = node_temp.next
    end
    # final
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
