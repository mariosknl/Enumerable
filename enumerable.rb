module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    count = 0
    is_2darr = false
    is_2darr = true unless self.class == Array
    if is_2darr
      t_arr = to_a
      until count == t_arr.length
        yield(t_arr[count][0], t_arr[count][1])
        count += 1
      end
    else
      until count == length
        yield(self[count])
        count += 1
      end
    end
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    count = 0
    is_2darr = false
    is_2darr = true unless self.class == Array
    if is_2darr
      t_arr = to_a
      until count == t_arr.length
        yield(t_arr[count], count)
        count += 1
      end
    else
      until count == length
        yield(self[count], count)
        count += 1
      end
    end
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    temp_a = []
    temp_h = {}
    is_2darr = false
    is_2darr = true unless self.class == Array
    is_2darr == true ? my_each { |x, y| temp_h[x] = y if yield(x, y) } : my_each { |x| temp_a << x if yield(x) }
    is_2darr == false ? temp_a : temp_h
  end

  def my_all?(*datatype)
    block = create_block if !block_given? && datatype.empty?
    return my_all?(&block) unless block.nil?

    if is_a? Array
      my_each do |x|
        return false if (!datatype.empty? && (datatype[0].class != Regexp) && (!x.is_a? datatype[0])) ||
                        (!datatype.empty? && (datatype[0].class == Regexp) && x.to_s.match(datatype[0]).nil?) ||
                        (datatype.empty? && (!yield(x) || x.nil?))
      end
    else
      my_each do |x, y|
        return false if !datatype.empty? || (datatype.empty? && !yield(x, y))
      end
    end
    true
  end

  def my_any?(*datatype)
    block = create_block if !block_given? && datatype.empty?
    return my_any?(&block) unless block.nil?

    if is_a? Array
      my_each do |x|
        return true if (!datatype.empty? && (datatype[0].class != Regexp) && (x.is_a? datatype[0])) ||
                       (!datatype.empty? && (datatype[0].class == Regexp) && !x.to_s.match(datatype[0]).nil?) ||
                       (datatype.empty? && yield(x))
      end
    else
      my_each do |x, y|
        return true if datatype.empty? || yield(x, y)
      end
    end
    false
  end

  def my_none?(*datatype, &test)
    !my_any?(*datatype, &test)
  end

  protected

  def create_block
    exproc = proc do |x|
      x
    end
    exproc
  end
end
