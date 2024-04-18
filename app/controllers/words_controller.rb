class WordsController < ApplicationController
  before_action :set_word, only: %i[ update destroy ]
  before_action :word_info, only: [:show]

  # GET /words
  def index
    @words = Word.all

    render json: @words
  end

  # GET /words/1
  def show
    if @info.present?
      render json: @info
    else
      render json: { message: I18n.t("word_not_found") }, status: :not_found
    end
  end

  # POST /words
  def create
    @word = Word.new(word_params)

    if @word.save
      render json: @word, status: :created, location: @word
    else
      render json: @word.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /words/1
  def update
    if @word.update(word_params)
      render json: @word
    else
      render json: @word.errors, status: :unprocessable_entity
    end
  end

  # DELETE /words/1
  def destroy
    @word.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_word
      @word = Word.find(params[:id])
    end

    def word_info
      @info = Word.search_word(params[:word])
    end

    # Only allow a list of trusted parameters through.
    def word_params
      params.require(:word).permit(:word, :syllabic_division)
    end
end
