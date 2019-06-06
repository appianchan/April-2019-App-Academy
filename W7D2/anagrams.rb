require 'byebug'


def first_anagram?(str1, str2)
    time = Time.now
    arr1 = str1.split('').permutation.to_a
    arr1 = arr1.map{|combo| combo.join('')}
    p arr1.include?(str2)
    return Time.now - time
end


def second_anagram?(str1, str2)
    time = Time.now
    str1.each_char do |char|
        if str2.include?(char)
            i = str2.index(char)
            str2 = str2[0...i] + str2[i+1..-1]
        else
            p false
            return Time.now - time
        end
    end
    p true
    return Time.now - time
end

def third_anagram?(str1, str2)
    time = Time.now
    alphabet = ("a".."z").to_a
    arr1 = ""
    arr2 = ""

    alphabet.each do |alpha|
        until !str1.include?(alpha)
            arr1 += alpha
            i = str1.index(alpha)
            str1 = str1[0...i] + str1[i+1..-1]
        end
         until !str2.include?(alpha)
            arr2 += alpha
            i = str2.index(alpha)
            str2 = str2[0...i] + str2[i+1..-1]
        end
    end
    if arr2 == arr1
        return Time.now - time
    else 
        return Time.now - time
    end
end

def fourth_anagram?(str1, str2)
    time = Time.now
    hash1 = Hash.new{0}
    str1.each_char do |char|
        hash1[char] += 1
    end
    str2.each_char do |char|
        if hash1[char] > 0
            hash1[char] -= 1
        else
            return Time.now - time
        end
    end
    true
    puts Time.now - time
end

# anagram?("gizmo", "sally")    #=> false÷
# puts first_anagram?("elvislweww", "liveslweww")
puts second_anagram?("elvislweww", "liveslweww")
puts third_anagram?("elvislweww", "liveslweww")
puts fourth_anagram?("elvislweww", "liveslweww")


