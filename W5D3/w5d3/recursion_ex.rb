require "byebug"
# Warmup

    # Write a recursive method, range, that takes a start and an end and 
    # returns an array of all numbers in that range, exclusive. 
    # For example, range(1, 5) should return [1, 2, 3, 4]. 
    # If end < start, you can return an empty array.
def warmup(start, finish)
    return [start] if start == finish - 1
    return [] if finish < start
    [start] + warmup(start + 1, finish)
end
# p warmup(1, 5)
# p warmup(2, 7)
# p warmup(7, 4)

    # Write both a recursive and iterative version of sum of an array.

def sum_rec(array)
    return array[0] if array.length == 1
    array[0] + sum_rec(array[1..-1])
end

# p sum_rec([1, 2, 3, 4])
# p sum_rec([2, 3, 4, 5, 6])
def sum_it(array)
    final = 0
    (0...array.length).each do |el|
        final += array[el]
    end
    final
end
# p sum_it([1, 2, 3, 4])
# p sum_it([2, 3, 4, 5, 6])



# Exponentiation
    # Write two versions of exponent that use two different recursions:
    # this is math, not Ruby methods.

    # recursion 1
    # exp(b, 0) = 1
    # exp(b, n) = b * exp(b, n - 1)

def rec1(b, n)
    return b if n == 1
    b * rec1(b, n-1)
end

# p rec1(2, 3) #=> 8
# p rec1(3, 3) #=> 27

    # # recursion 2
    # exp(b, 0) = 1
    # exp(b, 1) = b
    # exp(b, n) = exp(b, n / 2) ** 2             [for even n]
    # exp(b, n) = b * (exp(b, (n - 1) / 2) ** 2) [for odd n]
    # Note that for recursion 2, you will 
    # need to square the results of exp(b, n / 2) and (exp(b, (n - 1) / 2). 
    # Remember that you don't need to do anything special to square a number, 
    # just calculate the value and multiply it by itself. 
    # So don't cheat and use exponentiation in your solution.
def exp(b, n)
    return 1 if n == 0
    return b if n == 1
    if n % 2 == 0
        exp(b, n / 2) ** 2 
    else 
        b * (exp(b, (n - 1) / 2) ** 2)
    end
end

# p exp(2, 6) #=> 16
# p exp(3, 5) #=> 27


    # Suggestion: Break the methods down into parts.. Accessing this on GitHub? Use this link.

    # Suggestion 2: Try walking through your code with Simple Examples.

    # If the n == 256, about how many nested recursive steps will we run in the first case?

    # How deep will we need to recurse for the second? Keep in mind that the first reduces 
    # the exponent by one for each recursion, while the second reduces it by half.

    # In addition to testing your methods by running the code, try the following exercise:

    # On paper, write out the value of each variable for every line in the code:

    # Write out what happens with base 0 and power 0 as inputs 
    # (should be easy). e.g., if you had run exp(0,0).
    # Write out what happens for base 0 and power 1. e.g., if you had run exp(0,1).
    # Write out what happens for base 1 and power 0.
    # Write out what happens for base 1 and power 1.
    # Write out what happens for base 1 and power 2.
    # Write out what happens for base 2 and power 0.
    # Write out what happens for base 2 and power 1.
    # Write out what happens for base 2 and power 2.
    # Make sure you can trace from the very beginning to the very end in these examples.

    # How many examples do you need to walk through to be confident that it works?



# Deep dup
    # The #dup method doesn't make a deep copy:

    # robot_parts = [
    #   ["nuts", "bolts", "washers"],
    #   ["capacitors", "resistors", "inductors"]
    # ]

    # robot_parts_copy = robot_parts.dup

    # # shouldn't modify robot_parts
    # robot_parts_copy[1] << "LEDs"
    # # but it does
    # robot_parts[1] # => ["capacitors", "resistors", "inductors", "LEDs"]
    
    # When we dup an Array, it creates a new array to hold the elements, 
    # but doesn't recursively dup any arrays contained therein. 
    # So the dup method creates one new array, 
    # but just copies over references to the original interior arrays.

    # Sometimes you want a shallow dup and sometimes you want a deep dup. 
    # Ruby keeps things simple by giving you shallow dup, and letting you write deep dup yourself.

    # Using recursion and the is_a? method, write an Array#deep_dup method that 
    # will perform a "deep" duplication of the interior arrays.

    # Note: For simplicity's sake, we are only going to ensure the deep 
    # duplication of arrays. Don't worry about deep-duping (or regular-duping) 
    # other types of mutable objects (like strings, hashes, instances of custom classes, etc.), 
    # since this would require that we implement 
    # a deep dup method for each of those classes, as well.

    # It's okay to iterate over array elements using the normal each for this one :-)

    # You should be able to handle "mixed" arrays. For instance: [1, [2], [3, [4]]].

class Array
    def deep_dup
        # return [self] if !self.is_a(Array)

        final = []
        
        self.each do |el|
            if el.is_a?(Array)
                final += [el.deep_dup] 
            else
                final << el
            end
        end

        final
        
    end

end

# p [1, [2], [3, [4]]].deep_dup
#     robot_parts = [
#       ["nuts", "bolts", "washers"],
#       ["capacitors", "resistors", "inductors"]
#     ]

    # robot_parts_copy = robot_parts.dup

    # # shouldn't modify robot_parts
    # robot_parts_copy[1] << "LEDs"
    # # but it does
    # robot_parts[1] # => ["capacitors", "resistors", "inductors", "LEDs"]



# Fibonacci
    # Write a recursive and an iterative Fibonacci method. 
    # The method should take in an integer n and return the first n 
    # Fibonacci numbers in an array.

    # You shouldn't have to pass any arrays between methods; 
    # you should be able to do this just passing a single 
    # argument for the number of Fibonacci numbers requested.

def fib(n)
    return [] if n == 0
    return[1] if n == 1
    return[1, 1] if n == 2
    sum = fib(n - 1)
    number = sum[-1] + sum[-2]
    sum << number
end

# p fib(5)
# p fib(6)
# p fib(0)

# Binary Search
    # The binary search algorithm begins by comparing the target value to the 
    # value of the middle element of the sorted array. 
    # If the target value is equal to the middle element's value, 
    # then the position is returned and the search is finished. # base case?
    # If the target value is less than the middle element's value, 
    # then the search continues on the lower half of the array; 
    # or if the target value is greater than the middle element's value, 
    # then the search continues on the upper half of the array. 
    # This process continues, eliminating half of the elements, 
    # and comparing the target value to the value of the middle element of the 
    # remaining elements - until the target value is either found 
    # (and its associated element position is returned), 
    # or until the entire array has been searched (and "not found" is returned).

    # Write a recursive binary search: bsearch(array, target). 
    # Note that binary search only works on sorted arrays. 
    # Make sure to return the location of the found object (or nil if not found!). 
    # Hint: you will probably want to use subarrays.

    # Make sure that these test cases are working:
def bsearch(array, target)
    return nil if array.empty?
    midpoint = array.length / 2
    return midpoint if target == array[midpoint]
    upper = array[midpoint + 1..-1] #[4,5]
    lower = array[0...midpoint] #[2,3]
    if array[midpoint] < target 
        upper_sorted = bsearch(upper, target)
        return nil if upper_sorted == nil
        return midpoint + upper_sorted + 1
    else 
        return bsearch(lower, target)

    end
end
    # p bsearch([1, 2, 3], 1) # => 0
    # p bsearch([2, 3, 4, 5], 3) # => 1
    # p bsearch([2, 4, 6, 8, 10], 6) # => 2
    # p bsearch([1, 3, 4, 5, 9], 5) # => 3
    # p bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
    # p bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
    # p bsearch([1, 2, 3, 4, 5, 7], 6) # => nil



# Merge Sort
    # Implement a method merge_sort that sorts an Array:

    # The base cases are for arrays of length zero or one. 
    # Do not use a length-two array as a base case. This is unnecessary.
    # You'll want to write a merge helper method to merge the sorted halves.
    # To get a visual idea of how merge sort works, 
    # watch this gif and check out this diagram.

def merge_sort(array)
    return array if array.length <= 1

    midpoint = array.length/2
    upper = merge_sort(array[midpoint..-1])
    lower = merge_sort(array[0...midpoint])

    merge((upper), (lower))
end


def merge(upper, lower)
        # proc = Proc.new { |a , b| a<=>b }

    new_arr = []
    until lower.empty? || upper.empty?
        new_arr << (lower[0] < upper[0] ? lower.shift : upper.shift )
    
        # lower[0] < upper[0] ? new_arr << lower.shift : new_arr << upper.shift
        
        # new_arr << upper.shift 
        # if lower[0] < upper[0]
        #     new_arr << lower.shift
        # else
        #     new_arr << upper.shift
        # end 
      
        # until lower.empty? && upper.empty?
        # if proc.call(lower[0], upper[0]) == 1
        #     new_arr << upper[0] 
        #     upper.shift
        # elsif proc.call(lower[0], upper[0]) == -1
        #     new_arr << lower[0]
        #     lower.shift
        # else
        #     new_arr << lower[0] if lower[0] != nil
        #     lower.shift
        #     new_arr << upper[0] if upper[0] != nil
        #     upper.shift
        # end
        # end
    end
   
return new_arr + lower + upper
end

# p merge_sort([2, 5, 4, 3, 1])
# p merge_sort([2, 5, 4, 3, 1, 2, 7, 1, 9, 2, 5, 4, 3, 1, 2, 7, 1])
# p merge_sort([8, 5, 3, 9, 5, 7])



  

# Array Subsets
    # Write a method subsets that will return all subsets of an array.

    # subsets([]) # => [[]]
    # subsets([1]) # => [[], [1]]
    # subsets([1, 2]) # => [[], [1], [2], [1, 2]]
    # subsets([1, 2, 3])
    # # => [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]
    # You can implement this as an Array method if you prefer.

    # Hint: For subsets([1, 2, 3]), there are two kinds of subsets:

    # Those that do not contain 3 (all of these are subsets of [1, 2]).
    # For every subset that does not contain 3, 
    # there is also a corresponding subset that is the same, 
    # except it also does contain 3.

def subsets(array)
    return [array] if array.empty?
    final = []
    num = array.shift
    # lol = subsets([array])
    final << ([num] + subsets(array))
end

# p subsets([])
# p subsets([1])
# p subsets([1, 2])

# def substrings(length = nil)
#         subs = []
#         (0...self.length).each do |start_idx|
#             (start_idx...self.length).each do |end_idx|
#                 sub = self[start_idx..end_idx]
#                 subs << sub
#             end
#         end
#         return subs if length.nil?
#         subs.select { |string| string.length == length}

#     end

 
# Permutations
    # Write a recursive method permutations(array) that calculates all the 
    # permutations of the given array. 
    # For an array of length n there are n! different permutations. 
    # So for an array with three elements we will have 3 * 2 * 1 = 6 different permutations.

    # permutations([1, 2, 3]) # => [[1, 2, 3], [1, 3, 2],
    #                         #     [2, 1, 3], [2, 3, 1],
    #                         #     [3, 1, 2], [3, 2, 1]]
    # You can use Ruby's built in Array#permutation method to get a better 
    # understanding of what you will be building.

    # [1, 2, 3].permutation.to_a  # => [[1, 2, 3], [1, 3, 2],
    #                             #     [2, 1, 3], [2, 3, 1],
    #                             #     [3, 1, 2], [3, 2, 1]]



# Make Change
    # RubyQuiz: Make change.

    # Here's a game plan for solving the problem:

    # First, write a 'greedy' version called greedy_make_change:

    # Take as many of the biggest coin as possible and add them to your result.
    # Add to the result by recursively calling your method on the remaining amount, 
    # leaving out the biggest coin, until the remainder is zero.
    # Once you have a working greedy version, talk with your partner about 
    # refactoring this to make_better_change. What's wrong with greedy_make_change?

    # Consider the case of greedy_make_change(24, [10,7,1]). 
    # Because it takes as many 10 pieces as possible, 
    # greedy_make_change misses the correct answer of [10,7,7] (try it in pry).

    # To make_better_change, we only take one coin at a time and 
    # never rule out denominations that we've already used. 
    # This allows each coin to be available each time we get a new remainder. 
    # By iterating over the denominations and continuing to search for the best change, 
    # we assure that we test for 'non-greedy' uses of each denomination.

    # Discuss the following game plan and then work together to implement your new method:

    # Iterate over each coin.
    # Grab only one of that one coin and recursively 
    # call make_better_change on the remainder using coins less than or equal 
    # to the current coin.
    # Add the the single coin to the change returned by the recursive call. 
    # This will be a possible solution, but maybe not the best one.
    # Keep track of the best solution and return it at the end.
    # N.B. Don't generate every possible permutation of coins and then compare them. 
    # Remember that a permutation is not the same thing as a combination - 
    # we will need to check every combination of coins that add up to our target, 
    # we just don't want to check the same combination in different orders. 
    # If you get stuck you can start by writing a solution that calculates and 
    # compares all of the permutations without storing them in an array. 
    # Then go back and refactor your solution so that it only calculates and 
    # compares all of the different combinations. 
    # If you and your partner get totally stuck, or would like to compare your answer, 
    # feel free to reference this video walkthrough of the problem.

    # Make sure you and your partner understand each line before moving on.


