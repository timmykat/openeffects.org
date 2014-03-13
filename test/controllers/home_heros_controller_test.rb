require 'test_helper'

class HomeHerosControllerTest < ActionController::TestCase
  setup do
    @home_hero = home_heros(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:home_heros)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create home_hero" do
    assert_difference('HomeHero.count') do
      post :create, home_hero: { hero_image: @home_hero.hero_image }
    end

    assert_redirected_to home_hero_path(assigns(:home_hero))
  end

  test "should show home_hero" do
    get :show, id: @home_hero
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @home_hero
    assert_response :success
  end

  test "should update home_hero" do
    patch :update, id: @home_hero, home_hero: { hero_image: @home_hero.hero_image }
    assert_redirected_to home_hero_path(assigns(:home_hero))
  end

  test "should destroy home_hero" do
    assert_difference('HomeHero.count', -1) do
      delete :destroy, id: @home_hero
    end

    assert_redirected_to home_heros_path
  end
end
