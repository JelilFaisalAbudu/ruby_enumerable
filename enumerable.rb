# rubocop:disable Metrics/ModuleLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Style/CaseEquality
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

  def my_all?(arg = nil)
    my_each do |value|
      if block_given?
        return false unless yield value
      elsif arg.class == Class
        return false unless arg === value
      elsif arg.class == Regexp
        return false unless arg =~ arg
      else
        return false unless value == arg
      end
    end
    true
  end

  def my_any?(arg = nil)
    my_each do |value|
      if block_given?
        return true if yield value
      elsif arg.class == Class
        return true if arg === value
      elsif arg.class == Regexp
        return true if arg =~ value
      elsif arg
        return true if arg == value
      elsif value
        return true
      end
    end
    false
  end

  def my_none?(arg = nil)
    my_each do |value|
      if block_given?
        return false if yield value
      elsif arg.class == Class
        return false if arg === value
      elsif arg.class == Regexp
        return false if arg =~ value
      elsif arg
        return false if arg == value
      elsif value
        return false
      end
    end
    true
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

  def my_map(&block)
    result = []
    if !block_given?
      result = to_enum(:my_map)
    else
      my_each do |value|
        result.push(block.call(value))
      end
    end

    result
  end

  def my_inject(*arguments)
    array = is_a?(Array) ? self : to_a
    if arguments.length.positive? && arguments[0].class != Symbol
      accumulator = arguments[0]
      array.my_each { |item| accumulator = yield(accumulator, item) }
    elsif arguments.length.zero?
      accumulator = to_a[0]
      array[1..-1].my_each { |item| accumulator = yield(accumulator, item) }
    elsif arguments[0].class == Symbol
      accumulator = to_a[0]
      operation = arguments[0]
      array[1..-1].my_each { |item| accumulator = accumulator.send(operation, item) }
    end
    accumulator
  end

  def multiply_els(array)
    array.my_inject(:*)
  end
end

# rubocop:enable Metrics/ModuleLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Style/CaseEquality

p [2, 4, 4].my_map
