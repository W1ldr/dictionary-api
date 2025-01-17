class Word < ApplicationRecord
  has_many :meanings

  validates :word, presence: true
  validates :word, uniqueness: true
  
  paginates_per 20

  def self.find_word(word)
    word = Word.find_by(word: word)
    return word.info if word.present?
  end

  def self.search_words(page, per_page, word = nil, start_with = nil)
    
    words = Word.where("lower(word) like ?", "%#{word.downcase}%").order(word: :asc).page(page).per(per_page)
    
    if start_with.nil?
      words = Word.order(word: :asc).page(page).per(per_page)
    else
      words = Word.where("lower(word) like ?", "#{letter.downcase}%")
    end
    
    words_array = words.pluck(:word)
    return {
      "words": words_array,
      "pagination": {
        "current_page":  words.current_page, 
        "next_page":     words.next_page,
        "prev_page":     words.prev_page,
        "total_pages":   words.total_pages,
      }
    }
  end



  def self.list_of_words(page, per_page, letter = nil)

    
    words_array = words.pluck(:word)
    return {
      "words": words_array,
      "pagination": {
        "current_page":  words.current_page, 
        "next_page":     words.next_page,
        "prev_page":     words.prev_page,
        "total_pages":   words.total_pages,
      }
    }
  end

  def info
    meanings = []
    
    self.meanings.each do |meaning|
      meanings.push({
        "part_of_speech":  meaning.part_of_speech,
        "definition": meaning.definition
      })
    end

    return {
      "word": self.word,
      "syllabic_division": self.syllabic_division,
      "meanings": meanings
    }
  end

end
