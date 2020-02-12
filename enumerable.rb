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
    if is_2darr
      my_each { |x, y| temp_h[x] = y if yield(x, y) }
    else
      my_each { |x| temp_a << x if yield(x) }
    end
    is_2darr == false ? temp_a : temp_h
  end
end
