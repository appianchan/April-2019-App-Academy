class Node
    def dfs(&prc)
        raise 'err' if prc.nil?

        return self if prc.call(self)

        self.children.each do |child|
            return child.dfs(&prc) if prc.call(child) != nil
        end
        nil

    end

end


_______
class Node

  # -- Assume nodes have a value, and a attr_reader on value
  # -- Also, assume there are working parent/child-related methods for Node
  def dfs(target, &prc)
    raise "Must give a proc or target" if prc.nil?

    return self if prc.call(self)

    self.children.each do |node|
      result = node.dfs(target, &prc)
      return result if result
    end

    nil
  end
end