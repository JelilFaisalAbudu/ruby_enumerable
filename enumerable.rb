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
    result =[]
    if block_given?
      self.my_each do |el|
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
      self.my_each do |value|
         flag = false unless yield value
      end
    end
    flag
  end

  def my_any?
    flag = false
    if block_given?
      self.my_each do |value|
        if yield value
          flag = true
          break
        end
      end
    end
    flag
  end
end

p [2, 4, 4].my_select
