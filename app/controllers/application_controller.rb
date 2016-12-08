class ApplicationController < ActionController::Base
  before_filter :current_user	
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # skip_before_action :verify_authenticity_token, if: :valid_rest_json_request?
  # http_basic_authenticate_with name:'admin',password:'admin', if: :valid_rest_json_request?

  def current_user
   @current_user = User.find(session[:user_id]) if not session[:user_id].blank?
   @current_user = ApiKey.find_by(access_token: request.headers['HTTP_AUTHORIZATION'].gsub('Token','').strip).try(:user) if format_json?
  end

  def generate_token
    responce = User.authenticate(params[:email], params[:password])
    if(responce[:data][:status]==true)
      data = ApiKey.create(user_id: responce[:data][:user].try(:id))
     render json: {data: {status: true, token: data.access_token, expires_in: Time.now+3.minutes}}
    else
      render json: {data: {status: false}}
    end
  end


  protected

  def valid_rest_json_request?
    request.format.json?
  end

  private

  def format_json?
    request.format.json?
  end

end


#curl http://localhost:4000//generate_token?email=test@test.com&password=test123