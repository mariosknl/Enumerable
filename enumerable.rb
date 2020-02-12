module Enumerable
    def my_each
        return to_enum(:my_each) unless block_given?
        count = 0
        is_2D_arr = false
        unless self.class == Array then is_2D_arr = true end
        if is_2D_arr
            t_arr = self.to_a
            until count == t_arr.length
                yield(t_arr[count][0],t_arr[count][1])
                count += 1
            end
        else
            until count == self.length
                yield(self[count])
                count += 1
            end
        end
        return
    end

    def my_each_with_index
        return to_enum(:my_each_with_index) unless block_given?
        count = 0
        is_2D_arr = false
        unless self.class == Array then is_2D_arr = true end
        if is_2D_arr 
            t_arr = self.to_a
            until count == t_arr.length
                yield(t_arr[count], count)
                count += 1
            end
        else
            until count == self.length
                yield(self[count],count)
                count += 1
            end
        end
    end
end
