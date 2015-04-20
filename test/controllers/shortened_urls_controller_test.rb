require 'test_helper'

class ShortenedUrlsControllerTest < ActionController::TestCase
  setup do
    @shortened_url = shortened_urls(:one)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shortened_url" do
    assert('ShortenedUrl.count') do
      post :create, shortened_url: { url: @shortened_url.url }
    end
  end

  test "should show shortened_url" do
    get :show, id: @shortened_url
    assert_response :success
  end
end
