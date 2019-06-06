class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    final = 0
    self.each_with_index do |num, ind|
        final+= num.hash*ind
    end
    return final
  end
end

class String
  def hash
    alphabet = ("a".."z").to_a + ("A".."Z").to_a
    sum = 0
    (0..self.length-1).each do |i|
      sum += alphabet.index(self[i]) * i
    end
    sum.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    sum=0
    self.each do |k,v|
      sum+= k.hash + v.hash
    end
    sum.hash
  end
end
