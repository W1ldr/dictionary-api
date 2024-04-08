require "test_helper"

class MeaningsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @meaning = meanings(:one)
  end

  test "should get index" do
    get meanings_url, as: :json
    assert_response :success
  end

  test "should create meaning" do
    assert_difference("Meaning.count") do
      post meanings_url, params: { meaning: { definition: @meaning.definition, part_of_speech: @meaning.part_of_speech } }, as: :json
    end

    assert_response :created
  end

  test "should show meaning" do
    get meaning_url(@meaning), as: :json
    assert_response :success
  end

  test "should update meaning" do
    patch meaning_url(@meaning), params: { meaning: { definition: @meaning.definition, part_of_speech: @meaning.part_of_speech } }, as: :json
    assert_response :success
  end

  test "should destroy meaning" do
    assert_difference("Meaning.count", -1) do
      delete meaning_url(@meaning), as: :json
    end

    assert_response :no_content
  end
end
