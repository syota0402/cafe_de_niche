require 'test_helper'

class CoffeeShopsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get coffee_shops_index_url
    assert_response :success
  end

  test "should get show" do
    get coffee_shops_show_url
    assert_response :success
  end

  test "should get new" do
    get coffee_shops_new_url
    assert_response :success
  end

  test "should get create" do
    get coffee_shops_create_url
    assert_response :success
  end

  test "should get edit" do
    get coffee_shops_edit_url
    assert_response :success
  end

  test "should get update" do
    get coffee_shops_update_url
    assert_response :success
  end

  test "should get destroy" do
    get coffee_shops_destroy_url
    assert_response :success
  end

end
