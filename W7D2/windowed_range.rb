def naive(arr, window)
    current_max_range = nil
    arr.each_with_index do |el, i|
        if i + window > arr.length
            break
        end
        array = arr[i...i+window]
        min = array.min
        max = array.max
        max_range = max - min
        if current_max_range == nil || current_max_range < max_range
            current_max_range = max_range
        end
    end
    current_max_range
end

# p naive([1, 0, 2, 5, 4, 8], 2) #== 4 # 4, 8
# p naive([1, 0, 2, 5, 4, 8], 3) #== 5 # 0, 2, 5
# p naive([1, 0, 2, 5, 4, 8], 4) #== 6 # 2, 5, 4, 8
# p naive([1, 3, 2, 5, 4, 8], 5) #== 6 # 3, 2, 5, 4, 8



class MyQueue
    def initialize
        @store = []
    end


    def peek
        @store[0]
    end

    def size
        @store.length
    end

    def empty?
        @store.empty?
    end

    def enqueue(num)
        @store << num
    end

    def dequeue
        @store.shift
    end

end

class MyStack
    def initialize
        @store = []
    end


    def peek
        @store[0]
    end

    def size
        @store.length
    end

    def empty?
        @store.empty?
    end

    def push(num)
        @store.push(num)
    end

    def pop
        @store.pop
    end

end



class StackQueue
    def initialize
        @store = MyStack.new
    end

    def size
        @store.store.length
    end

    def empty?
        @store.store.empty?
    end

    def enqueue(stack)
        @store.store.push(stack)
    end

    def dequeue
        @store.pop
    end
end