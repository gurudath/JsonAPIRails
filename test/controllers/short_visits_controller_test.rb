require 'test_helper'

class ShortVisitsControllerTest < ActionController::TestCase
  setup do
    @short_visit = short_visits(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:short_visits)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create short_visit" do
    assert_difference('ShortVisit.count') do
      post :create, short_visit: { short_url_id: @short_visit.short_url_id, visitor_city: @short_visit.visitor_city, visitor_country: @short_visit.visitor_country, visitor_country_iso: @short_visit.visitor_country_iso, visitor_ip: @short_visit.visitor_ip, visitor_state: @short_visit.visitor_state }
    end

    assert_redirected_to short_visit_path(assigns(:short_visit))
  end

  test "should show short_visit" do
    get :show, id: @short_visit
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @short_visit
    assert_response :success
  end

  test "should update short_visit" do
    patch :update, id: @short_visit, short_visit: { short_url_id: @short_visit.short_url_id, visitor_city: @short_visit.visitor_city, visitor_country: @short_visit.visitor_country, visitor_country_iso: @short_visit.visitor_country_iso, visitor_ip: @short_visit.visitor_ip, visitor_state: @short_visit.visitor_state }
    assert_redirected_to short_visit_path(assigns(:short_visit))
  end

  test "should destroy short_visit" do
    assert_difference('ShortVisit.count', -1) do
      delete :destroy, id: @short_visit
    end

    assert_redirected_to short_visits_path
  end
end
