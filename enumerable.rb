module Enumerable
  def my_each
    if block_given?
      length.times do |el|
        yield self[el]
      end
      self
    else
      to_enum(:my_each)
    end
  end

  def my_each_with_index
    if block_given?
      length.times do |indx|
        yield self[indx], indx
      end
      self
    else
      to_enum(:my_each_with_index)
    end
  end

  def my_select
    result = []
    if block_given?
      my_each do |el|
        result << el if yield el
      end
      result
    else
      to_enum(:my_select)
    end
  end

  def my_all?
    flag = true
    if block_given?
      my_each do |value|
        flag = false unless yield value
      end
    end
    flag
  end

  def my_any?
    flag = false
    if block_given?
      my_each do |value|
        if yield value
          flag = true
          break
        end
      end
    end
    flag
  end

  def my_none?
    flag = true
    if block_given?
      my_each do |value|
        if yield value
          flag = false
          break
        end
      end
    end
    flag
  end

  def my_count(arg = nil)
    counter = 0

    if !arg.nil?
      my_each do |value|
        counter += 1 if value == arg
      end
    elsif block_given?
      my_each do |value|
        counter += 1 if yield value
      end
    else
      my_each do
        counter += 1
      end
    end

    counter
  end

  def my_map
    result = []

    if block_given?
      my_each do |value|
        result.push(yield value)
      end
    else
      result = to_enum(:my_map)
    end
    result
  end

  def my_inject
    def my_inject(*args)
      new_array = is_a?(Array) ? self : to_a
      memo = args[0] if args[0].is_a? Integer
      if args[0].is_a?(Symbol) || args[0].is_a?(String)
        sym = args[0]
      elsif args[0].is_a?(Integer)
        sym = args[1] if args[1].is_a?(Symbol) || args[1].is_a?(String)
      end
      if sym
        new_array.my_each do |item|
          memo = if memo
              memo.send(sym, item)
            else
              item
            end
        end
      else
        new_array.my_each do |item|
          memo = if memo
              yield(memo, item)
            else
              item
            end
        end
      end
      memo
    end
  end

  def multiply_els(array)
    array.my_inject(:*)
  end
end

p [2, 4, 4].my_count(-1)
