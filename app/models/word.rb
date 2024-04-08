class Word < ApplicationRecord
  has_many :meanings
  
  def self.search_word(word)
    word = Word.find_by(w: word)   
    return word.info if word.present?
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
      "word": self.w,
      "syllabic_division": self.syllabic_division,
      "meanings": meanings
    }
  end

end
