require "test_helper"

class WordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @word = words(:one)
  end

  test "should get index" do
    get words_url, as: :json
    assert_response :success
  end

  test "should create word" do
    assert_difference("Word.count") do
      post words_url, params: { word: { syllabic_division: @word.syllabic_division, w: @word.w } }, as: :json
    end

    assert_response :created
  end

  test "should show word" do
    get word_url(@word), as: :json
    assert_response :success
  end

  test "should update word" do
    patch word_url(@word), params: { word: { syllabic_division: @word.syllabic_division, w: @word.w } }, as: :json
    assert_response :success
  end

  test "should destroy word" do
    assert_difference("Word.count", -1) do
      delete word_url(@word), as: :json
    end

    assert_response :no_content
  end
end
