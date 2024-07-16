class WordsController < ApplicationController
  before_action :word_info, only: [:show]
  before_action :search_params, only: [:index]

  # GET /words
  def index
    render json: Word.list_of_words(@page, @per_page, @letter)
  end

  # GET /words/:word
  def show
    if @info.present?
      render json: @info
    else
      render json: { message: I18n.t("word_not_found") }, status: :not_found
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def word_info
      @info = Word.search_word(params[:word])
    end

    def search_params
      @page = params[:page].to_i
      @per_page = params[:per_page].to_i
      @letter = params[:letter]
      
      if @per_page.nil? || @per_page.zero? || @per_page > 20
        @per_page = 20
      end
      if @page.nil? || @page.zero?
        @page = 1
      end
   
      if @letter.present?
       @letter = nil if !@letter.match?(/\A[a-zA-Z]\z/) || @letter.size != 1
     end
    end

    # Only allow a list of trusted parameters through.
    def word_params
      params.require(:word).permit(:word, :syllabic_division)
    end
end
