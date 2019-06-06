require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    real_node = nil
    if !@store.include?(key)
      @prc.call(key)
      insert(key)
      @store.each do |node|
        if node.key == key
          real_node = node
          break 
        end
      end
      @map.set(key, real_node)
    else
      @store.each do |node|
        if node.key == key
          real_node = node
          break 
        end
      end
      update_node!(real_node)
    end
    if @store.count > @max
      eject!
    end


  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private
  def insert(key)
    if !@store.include?(key)
      @store.append(key, 1)
    end
  end

  def move_to_end(node)
    node.next = @store.tail
    node.prev = @store.tail.prev
    node.prev.next = node
    @store.tail.prev = node
  end

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    @store.remove(node.key)
    @store.append(node.key, node.val)
  end

  def eject!
    node = @store.first
    @map.delete(node.key)
    @store.head.next = @store.head.next.next
    @store.head.next.prev = @store.head
  end
end
