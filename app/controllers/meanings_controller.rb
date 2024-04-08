class MeaningsController < ApplicationController
  before_action :set_meaning, only: %i[ show update destroy ]

  # GET /meanings
  def index
    @meanings = Meaning.all

    render json: @meanings
  end

  # GET /meanings/1
  def show
    render json: @meaning
  end

  # POST /meanings
  def create
    @meaning = Meaning.new(meaning_params)

    if @meaning.save
      render json: @meaning, status: :created, location: @meaning
    else
      render json: @meaning.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /meanings/1
  def update
    if @meaning.update(meaning_params)
      render json: @meaning
    else
      render json: @meaning.errors, status: :unprocessable_entity
    end
  end

  # DELETE /meanings/1
  def destroy
    @meaning.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meaning
      @meaning = Meaning.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def meaning_params
      params.require(:meaning).permit(:part_of_speech, :definition)
    end
end
