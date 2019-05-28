require 'byebug'
class Array

    def my_each(&prc)
        i = 0
        while i < self.length
            prc.call(self[i])
            i += 1
        end
self
    end
#     return_value = [1, 2, 3].my_each do |num|
#   puts num
# end.my_each do |num|
#   puts num
# end
# # => 1
#      2
#      3
#      1
#      2
#      3

# p return_value  # => [1, 2, 3]

    def my_select(&prc)
        final = []
        i = 0
        while i < self.length
            if prc.call(self[i])
                final << self[i]
            end
            i+=1
        end
        final
    end

#     a = [1, 2, 3]
# p a.my_select { |num| num > 1 } # => [2, 3]
# p a.my_select { |num| num == 4 } # => []

    def my_reject(&prc)
         final = []
        i = 0
        while i < self.length
            if !prc.call(self[i])
                final << self[i]
            end
            i+=1
        end
        final
    end

#     a = [1, 2, 3]
# p a.my_reject { |num| num > 1 } # => [1]
# p a.my_reject { |num| num == 4 } # => [1, 2, 3]

    def my_any?(&prc)
        i = 0
        while i < length
            return true if prc.call(self[i])
            i += 1
        end
false
    end

    # p a.my_any? { |num| num > 1 } # => true
    # p a.my_any? { |num| num == 4 } # => false
    
    def my_all?(&prc)
        i = 0
        while i < length
            return false unless prc.call(self[i])
            i += 1
        end
        true
        
    end
#     a = [1, 2, 3]
# p a.my_all? { |num| num > 1 } # => false
# p a.my_all? { |num| num < 4 } # => true

    def my_flatten
        return [self] if !self.is_a?(Array)
        flattened = []
        self.each do |el|
            if el.is_a?(Array)
                flattened += el.my_flatten
            else
                flattened << el
            end
        end
        flattened
    end
    # p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]

    def my_zip(*arrays)
        outer = []
        self.each_with_index do |el1, idx|
            sub = [self[idx]]
            arrays.each do |arr|
                sub << arr[idx]
            end
            outer << sub
        end
        outer
    end
# a = [ 4, 5, 6 ]
# b = [ 7, 8, 9 ]
# p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
# p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
# p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]
# c = [10, 11, 12]
# d = [13, 14, 15]
# p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]
    
    def my_rotate(rot = 1)
        dself = self.dup
        # debugger
        return dself if self.length == 1
      
        if rot > 0
            rot.times do 
                temp = dself.shift
                dself << temp
            end
        else
            rot = rot*(-1)
            rot.times do
                temp = dself.pop
                dself.unshift(temp)
            end
        end
    dself
    end
#     a = [ "a", "b", "c", "d" ]
# p a.my_rotate         #=> ["b", "c", "d", "a"]
# p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
# p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
# p a.my_rotate(15)     #=> ["d", "a", "b", "c"]
    
    def my_join(var = "")
        str = ""
        self.each do |el|
            str += el + var
        end
       return str[0..-2] if var != ""
      str
    end
# a = [ "a", "b", "c", "d" ]
# p a.my_join         # => "abcd"
# p a.my_join("$")    # => "a$b$c$d"

# def my_reverse
#     arr = []
#     i = self.length - 1
#     while i >= 0
#         arr << self[i]
#         i -= 1
#     end
# arr

# end

def my_reverse
    return self if self.length == 0
    rev = [self[-1]]
    rev += self[0..-2].my_reverse
end
# p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
# p [ 1 ].my_reverse               #=> [1]



end


#factors(num)
#bubble_sort!(&prc)
#bubble_sort(&prc)
#substrings(string)
#subwords(word, dictionary)