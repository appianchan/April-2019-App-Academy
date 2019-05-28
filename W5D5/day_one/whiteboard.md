class Array
    def merge_sort(&prc)
    return self if self.length <= 1
    midpoint = self.length/2
    left = self[0..midpoint]
    right = self[midpoint+1..-1]

    left = left.merge_sort(&prc)
    right = right.merge_sort(&prc)

    Array.merge(left, right, &prc)
    end


    def merge(left, right, &prc)
        prc ||= Proc.new(|a,b|a<=>b)
        final = []
        until left.empty? || right.empty?
            final << (prc.call(left.first, right.first) == 1 ? right.shift : left.shift)
        end

        final + left + right
    
    end

    def my_flatten(level = nil)
        if level != nil
            return self.dup if level == 0

            final = []

            self.each do |el|
                if el.is_a?(Array)
                    final << el.my_flatten(level - 1)
                else
                    final << el
                end
            end

            return final
        else
            return [self] if !self.is_a(Array)

            final = []

            self.each do |el|
                if el.is_a?(Array)
                    final << el.my_flatten(nil)
                else
                    final << el
                end
            end
            return final
        end


    end

    def my_flatten(level = nil)
    duped = self.dup
    return duped if level == 0
    next_level = level ? level - 1 : nil

    each_with_index do |el, i|
      duped[i..i] = el.my_flatten(next_level) if el.is_a?(Array)
    end

    duped
    end


    def reduced(accumulator = nil, &blk)
    end


end

