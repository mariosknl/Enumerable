require_relative '../enumerable.rb'

describe Enumerable do

    let(:array) {[1,2,3,4,5,6]}
    let(:hash) {{harry: 1, friends: 2, bigbang:3}}
    let(:str_array) {%w[ant bear cat]}
    let(:range) {(0..10)}
    let(:block) {proc { |x| x } }
    let(:word_length) {proc {|x| x.length >= 3 }}
    let(:word_length2){proc {|x| x.length >= 4 }}
    let(:word_length3){proc {|x| x.length == 5 }}
    let(:reg_exp_tab){/t/}
    let(:reg_exp_digit){/d/}
    let(:arr_numbers){[1,2i,3.14]}
    let(:arr_floats){[1,3.14,42]}
    let(:arr_false_true){[nil,true,99]}
    let(:arr_square){ proc { |x| x*x }}
    let(:even_num){ proc { |x| x.even? } }
    let(:equal_num){proc {|x| x == 3} }
    let(:not_l){[nil]}
    let(:arr_false){%w[nil false]}
    let(:arr_true){%w[nil false true]}


    describe '.my_each' do
        it 'return Enumerator if no block' do
            expect(array.my_each.class).to be Enumerator
        end
    end

    describe '.my_each_with_index' do

    end

# (1..10).find_all { |i|  i % 3 == 0 }   #=> [3, 6, 9]

# [1,2,3,4,5].select { |num|  num.even?  }   #=> [2, 4]

# [:foo, :bar].filter { |x| x == :foo }   #=> [:foo]

    describe '.my_select' do

        it "returns an array containing all elements which meets the conditions" do
            expect(range.my_select(&even_num)).to eql(range.select(&even_num))
        end

    end

    describe '.my_all?' do
      
      it "returns true if all items meets the condition" do
        expect(str_array.my_all?(&word_length)).to eql(str_array.all?(&word_length))
      end

      it "returns false not all items meets the condition" do
        expect(str_array.my_all?(&word_length2)).not_to be true
      end

      it "returns false when not all items match with the RegExp" do
        expect(str_array.my_all?(reg_exp_tab)).to eql(str_array.all?(reg_exp_tab))
      end

      it "returns true all items has the same class" do
        expect(arr_numbers.my_all?(Numeric)).to be true
      end

      it "returns false|true if items are false|true" do
        expect(arr_false_true.my_all?).to eql(arr_false_true.all?)
      end

      it "returns true if the array is empty and no arguments" do
        expect([].my_all?).to eql([].all?)
      end

    end

    describe '.my_any?' do
        it "returns true if any item meets the condition" do
            expect(str_array.my_any?(&word_length)).to eql(str_array.any?(&word_length))
          end
    
          it "Should not return false if any item meets the condition" do
            expect(str_array.my_any?(&word_length2)).not_to be false
          end
    
          it "returns true if at least any item match with the RegExp" do
            expect(str_array.my_any?(reg_exp_digit)).to eql(str_array.any?(reg_exp_digit))
          end
    
          it "returns true any item has the same class" do
            expect(arr_false_true.my_any?(Integer)).to be true
          end
    
          it "returns true if any item is true" do
            expect(arr_false_true.my_any?).to eql(arr_false_true.any?)
          end
    
          it "returns true if the array is empty and no arguments" do
            expect([].my_any?).to eql([].any?)
          end

          it "returns true if there any number equal in the range" do
            expect(range.my_any?(&equal_num)).to eql(range.any?(&equal_num))
          end
    end

    describe '.my_none?' do
          it "returns true if the block never returns true for all elements" do
            expect(str_array.my_none?(&word_length3)).to eql(str_array.none?(&word_length3))
          end

          it "returns true If instead a pattern is supplied, the method returns whether pattern === element for none of the collection members" do
            expect(str_array.my_none?(reg_exp_digit)).to eql(str_array.none?(reg_exp_digit))
          end
          
          it "returns false if any item return true" do
            expect(arr_floats.my_none?).to eql(arr_floats.none?)
          end
        
        it "returns true if the array is empty and there is not an argument" do 
            expect([].my_none?).to eql([].none?)
        end
        
        it "returns true only if none of the collection members is true" do
            expect(not_l.my_none?).to eql(not_l.none?)
        end

        it "returns true only if none of the collection members is true" do
            expect(arr_false.my_none?).to eql(arr_false.none?)
        end

        it "returns false if one of the collection memebers is true" do
            expect(arr_true.my_none?).to eql(arr_true.none?)
        end
    end

    describe '.my_count' do

        it 'returns the number of items in enum thourgh enumeration' do
            expect(array.my_count).to eql(array.count)
        end

        it 'returns the number of items in enum thourgh enumeration with a condition as argument' do
            expect(array.my_count(2)).to eql(array.count(2))
        end

        it 'returns the number of items in enum thourgh enumeration with a block as a condition' do
            expect(array.my_count(&even_num)).to eql(array.count(&even_num))
        end
        
        it 'returns the number of items that meets the condition in the block (strings)' do
            expect(str_array.my_count(&word_length)).to eql(str_array.count(&word_length))
        end

    end

    describe '.my_map' do

        it 'return Enumerator if no block given' do
            expect(array.my_map.class).to be Enumerator
        end

        it "returns a new array with the results of block" do
            expect(range.my_map(&block)).to eql(range.map(&block))
        end

        it "returns a new array with the results of block" do
            expect(range.my_map{'cat'}).to eql(range.map{'cat'})
        end
    end

    describe '.my_inject' do

    end

end