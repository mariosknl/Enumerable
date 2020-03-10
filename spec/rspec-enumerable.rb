require_relative '../enumerable.rb'

describe Enumerable do

    let(:array) {[1,2,3,4,5,6]}
    let(:hash) {{harry: 1, friends: 2, bigbang:3}}
    let(:str_array) {%w[ant bear cat]}
    let(:range) {(0..10)}
    let(:block) { proc { |x| x } }
    let(:word_length){proc {|x| x.length >= 3}}
    let(:word_length2){proc {|x| x.length >= 4}}
    let(:reg_exp_tab){/t/}
    let(:reg_exp_digit){/d/}
    let(:arr_numbers){[1,2i,3.14]}
    let(:arr_false_true){[nil,true,99]}


    describe '.my_each' do
        it 'return Enumerator if no block' do
            expect(array.my_each.class).to be Enumerator
        end
    end

    describe '.my_each_with_index' do

    end

    describe '.my_select' do

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
            expect(range.my_any?{|x| x == 3}).to eql(range.any?{|x| x == 3})
          end
    end

    describe '.my_none?' do

    end

    describe '.my_count' do

    end

    describe '.my_map' do

    end

    describe '.my_inject' do

    end

end