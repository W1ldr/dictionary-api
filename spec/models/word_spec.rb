require 'rails_helper'

RSpec.describe Word, type: :model do
  describe '.find_word' do
    let!(:word) { create(:word, word: 'example') }

    context 'when the word exists' do
      it 'returns the word info' do
        result = Word.find_word('example')
        expect(result).to include(:word, :syllabic_division, :meanings)
      end
    end

    context 'when the word does not exist' do
      it 'returns nil' do
        result = Word.find_word('nonexistent')
        expect(result).to be_nil
      end
    end

    context 'when trying to find with special characters' do
      let!(:word) { create(:word, word: 'word!') }

      it 'handles special characters gracefully' do
        result = Word.find_word('word!')
        expect(result).to include(:word, :syllabic_division, :meanings)
      end
    end
  end

  describe '.search_words' do
    let!(:word) { create(:word, word: 'example') }

    context 'when there are words matching' do
      it 'returns the word info' do
        result = Word.search_words(1, 20, 'example')
        expect(result).to include(:words, :pagination)
        expect(result[:words]).to include('example')
      end
    end

    context 'when there is no word matching' do
      it 'returns an empty array for words' do
        result = Word.search_words(1, 20, 'nonexistent')
        expect(result[:words]).to be_empty
      end
    end

    context 'when searching with different case' do
      let!(:word) { create(:word, word: 'Example') }

      it 'returns the word info regardless of case' do
        result = Word.search_words(1, 20, 'example')
        expect(result[:words]).to include('Example')
      end
    end

    context 'when searching with partial match' do
      let!(:word) { create(:word, word: 'example') }

      it 'returns the word info for partial matches' do
        result = Word.search_words(1, 20, 'ex')
        expect(result[:words]).to include('example')
      end
    end
  end

  describe '.list_of_words' do
    # Helper method to generate unique word names
    def generate_unique_word
      "word_#{SecureRandom.hex(4)}"
    end

    before do
      # Create unique words
      create_list(:word, 30) # Uses the sequence to ensure uniqueness in the factory
    end
  
    context 'without a letter filter' do
      it 'returns paginated words and pagination info' do
        result = Word.list_of_words(1, 20)
        expect(result[:words].length).to eq(20)
        expect(result[:pagination]).to include(:current_page, :next_page, :prev_page, :total_pages)
      end
    end
  
    context 'with a letter filter' do
      before do
        create(:word, word: 'apple')
        create(:word, word: 'apricot')
      end
  
      it 'returns words starting with the given letter' do
        result = Word.list_of_words(1, 20, 'a')
        expect(result[:words]).to include('apple', 'apricot')
      end
    end
  
    context 'when page is beyond total pages' do
      it 'returns an empty list of words' do
        result = Word.list_of_words(3, 20) # Page 2 should be empty if there are only 30 words
        expect(result[:words]).to be_empty
      end
    end
  
    context 'when per_page is set to a very large number' do
      it 'returns all words in one page' do
        result = Word.list_of_words(1, 100)
        expect(result[:words].length).to eq(30)
      end
    end
  
    context 'when per_page is set to a very small number' do
      it 'returns words with the correct pagination' do
        result = Word.list_of_words(1, 1)
        expect(result[:words].length).to eq(1)
        expect(result[:pagination][:total_pages]).to eq(30)
      end
    end
  end

  describe '#info' do
    context 'when the word has meanings' do
      let!(:word) { create(:word) }
      let!(:meaning1) { create(:meaning, word: word, part_of_speech: 'noun', definition: 'first definition') }
      let!(:meaning2) { create(:meaning, word: word, part_of_speech: 'verb', definition: 'second definition') }

      it 'returns word info with meanings' do
        result = word.info
        expect(result).to include(:word, :syllabic_division, :meanings)
        expect(result[:meanings].length).to eq(2)
        expect(result[:meanings].map { |m| m[:definition] }).to include('first definition', 'second definition')
      end
    end

    context 'when the word has no meanings' do
      let!(:word) { create(:word) }

      it 'returns word info with an empty meanings array' do
        result = word.info
        expect(result[:meanings]).to be_empty
      end
    end
  end

  describe 'validations' do
    context 'when validating uniqueness of word' do
      before { create(:word, word: 'unique') }

      it 'does not allow duplicate words' do
        duplicate_word = build(:word, word: 'unique')
        expect(duplicate_word).not_to be_valid
        expect(duplicate_word.errors[:word]).to include('has already been taken')
      end
    end

    context 'when validating presence of word attribute' do
      it 'requires the word to be present' do
        word = build(:word, word: nil)
        expect(word).not_to be_valid
        expect(word.errors[:word]).to include("can't be blank")
      end
    end
  end
end
