require_relative '../enumerable.rb'

describe Enumerable do
    let(:mod) {Enumerable}
    let(:array) {[1,2,3,4,5,6]}
    let(:hash) {{harry: 1, friends: 2, bigbang:3}}
    let(:str_array) {%w[ant bear cat]}
    let(:range) {(0..10)}

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

    end

    describe '.my_any?' do

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