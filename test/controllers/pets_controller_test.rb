require 'test_helper'

class PetsControllerTest < ActionController::TestCase

  # Necessary setup to allow ensure we support the API JSON type
  setup do
     @request.headers['Accept'] = Mime::JSON
     @request.headers['Content-Type'] = Mime::JSON.to_s
   end

  test "can get #index" do
    get :index
    assert_response :success
  end

  test "#index returns json" do
    get :index
    assert_match 'application/json', response.header['Content-Type']
  end

  test "#index returns an Array of Pet objects" do
    get :index
    # Assign the result of the response from the controller action
    body = JSON.parse(response.body)
    assert_instance_of Array, body
  end

  test "returns three pet objects" do
    get :index
    body = JSON.parse(response.body)
    assert_equal 3, body.length
  end

  test "each pet object contains the relevant keys" do
    keys = %w( age human id name )
    get :index
    body = JSON.parse(response.body)
    assert_equal keys, body.map(&:keys).flatten.uniq.sort
  end

  test "can get #show" do
    get :show, {id: pets(:one).id}
    assert_response :ok
  end

  test "#show returns json" do
    get :show, {id: pets(:one).id}
    assert_match 'application/json', response.header['Content-Type']
  end

  test "#show returns an Hash of a Pet" do
    get :show, {id: pets(:one).id}
    # Assign the result of the response from the controller action
    body = JSON.parse(response.body)
    assert_instance_of Hash, body
  end

  test "returns one pet objects with 4 key-values" do
    get :show, {id: pets(:one).id}
    body = JSON.parse(response.body)
    assert_equal 4, body.length
  end

  test "the one pet object contains the relevant keys" do
    keys = %w( age human id name )
    get :show, {id: pets(:one).id}
    body = JSON.parse(response.body)
    assert_equal keys, body.keys.sort
  end

  test "returns status no-content if not found" do
    get :show, {id: 134354}
    body = JSON.parse(response.body)
    assert_response :no_content
  end
end
