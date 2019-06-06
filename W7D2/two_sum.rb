require 'byebug'

def bad_two_sum?(arr, target_sum)
    array = []
    (0...arr.length-1).each do |i|
        (i+1...arr.length).each do |j| 
            array << arr[i] + arr[j]
        end
    end
    array.include?(target_sum)
end



# p bad_two_sum?(arr, 6) # => should be true
# p bad_two_sum?(arr, 10) # => should be false

def okay_two_sum?(arr, target_sum)
    array = arr.sort
    (0...array.length-1).each do |i|
        (i+1...array.length).each do |j| 
            return true if target_sum == array[i] + array[j]
        end
    end
    false
end

# p okay_two_sum?(arr, 6) # => should be true
# p okay_two_sum?(arr, 10) # => should be false


def two_sum?(arr, target_sum)
    hash = {}

    arr.each do |el|
        debugger
        if hash[target_sum - el]
            return true
        end
        hash[el] = true
    end
    false
end

arr = [0, 1, 5, 7]
p two_sum?(arr, 6)



# h = { "d" => 100, "a" => 200, "v" => 300, "e" => 400 }
# h.length        #=> 4
# h.delete("a")   #=> 200
# h.length        #=> 3


