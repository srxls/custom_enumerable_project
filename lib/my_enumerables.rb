module Enumerable
  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    i = 0
    while i < self.size
      yield(self[i], i)
      i += 1
    end

    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    res = []
    self.my_each { |x| res << x if yield(x) }

    res
  end
class Array
  def my_each
    return to_enum(:my_each) unless block_given?

    i = 0
    while i < self.size
      yield(self[i])
      i += 1
    end

    self
  end
end
