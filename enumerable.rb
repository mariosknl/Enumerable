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

  def my_any?(*datatype)
    exproc = create_block
    for_any(exproc, datatype, &exproc)
  end

  def my_none?(*datatype)
    exproc = create_block
    for_any(exproc, datatype, &exproc) == false
  end

  protected

  def for_any(prc, datatype)
    is_2darr = false
    is_2darr = true unless self.class == Array
    temp_response = check_if(is_2darr, self, datatype, &prc)
    temp_response
  end

  def check_if(is_2d, obj, datatype)
    tmp_res = false
    if is_2d
      obj.my_each do |x, y|
        if check_dtype(datatype)
          res = datatype[0].match(y.to_s) || datatype[0].match(x.to_s)
          tmp_res = true if res != nil
        elsif !datatype.empty?
          tmp_res = y.is_a? datatype[0]
          break if tmp_res
        else
          tmp_res = true if yield(x, y)
        end
      end
    else
      obj.my_each do |x|
        if check_dtype(datatype)
          res = datatype[0].match(x.to_s)
          tmp_res = true if res != nil
        elsif !datatype.empty?
          tmp_res = x.is_a? datatype[0]
          break if tmp_res
        else
          tmp_res = true if yield(x)
        end
      end
    end
    tmp_res
  end

  def create_block
    oexproc = proc do |x, y|
      yield(x, y)
    end
    twoexproc = proc do |x|
      x
    end
    block_given? ? oexproc : twoexproc
  end

  def check_dtype(value)
    value[0].class == Regexp
  end
end
