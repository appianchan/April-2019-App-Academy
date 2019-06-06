class Node

    def bfs(&prc)
        raise 'error' if prc.nil?#prc == nil
        queue = [self]

        until queue.empty?
            selected = queue.shift

            if prc.call(selected)
                return selected
            end

            queue += selected.children
            # selected.children.each do |child|
            #     queue << child
            # end

        end

        nil
    end
end