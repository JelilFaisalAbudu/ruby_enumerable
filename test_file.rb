module Enumerable

  def each(&block)
    if block_given?
      block.call(@head)
      @tail.each(&block) if @tail
    else
      to_enum(:each)
    end
  end

  def my_each_with_index 
    
  end
end
