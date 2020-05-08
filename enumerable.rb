module Enumerable

  def my_each
    if block_given?
      self.length.times do |el|
        yield self[el]
      end
      self
    else
      to_enum(:my_each)
    end
  end
end

 p [2, 4, 4].my_each
