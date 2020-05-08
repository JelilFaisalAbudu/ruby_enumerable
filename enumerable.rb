module Enumerable
  def my_each
    size.times do |x|
      yield self[x]
    end
    self
  end
end

p([2, 4, 4].my_each { |i| i * 2 })
