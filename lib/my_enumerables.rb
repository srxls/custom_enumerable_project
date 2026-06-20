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

  def my_any?
    if block_given?
      my_each { |x| return true if yield(x) }
    else
      my_each { |x| return true if x }
    end

    false
  end

  def my_none?
    if block_given?
      my_each { |x| return false if yield(x) }
    else 
      my_each { |x| return false if x }
    end

    true
  end

  def my_count(*arg)
    res = 0

    if block_given?
      my_each { |x| res += 1 if yield(x) }
    elsif !arg.empty?
      my_each { |x| res += 1 if x == arg[0] }
    else
      my_each { res += 1 }
    end

    res
  end

  def my_map
    return to_enum(:my_map) unless block_given?

    res = []
    my_each { |x| res << yield(x) }

    res
  end

  def my_inject(*args)
    arr   = to_a
    initial = args[0] if args.length >= 1 && !args[0].is_a?(Symbol)
    sym     = args.find { |a| a.is_a?(Symbol) }
    res     = initial || arr.shift
    arr.my_each { |x| res = block_given? ? yield(res, x) : res.send(sym, x)}
    res
  end
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
