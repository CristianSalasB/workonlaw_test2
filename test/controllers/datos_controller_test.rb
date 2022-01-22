require "test_helper"

class DatosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dato = datos(:one)
  end

  test "should get index" do
    get datos_url, as: :json
    assert_response :success
  end

  test "should create dato" do
    assert_difference("Dato.count") do
      post datos_url, params: { dato: { dato1: @dato.dato1 } }, as: :json
    end

    assert_response :created
  end

  test "should show dato" do
    get dato_url(@dato), as: :json
    assert_response :success
  end

  test "should update dato" do
    patch dato_url(@dato), params: { dato: { dato1: @dato.dato1 } }, as: :json
    assert_response :success
  end

  test "should destroy dato" do
    assert_difference("Dato.count", -1) do
      delete dato_url(@dato), as: :json
    end

    assert_response :no_content
  end
end
