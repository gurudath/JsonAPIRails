class  Api::V1::ShortVisitsController < ApplicationController
  before_filter :restrict_access , :if => :format_json?

  before_action :set_short_visit, only: [:show, :edit, :update, :destroy]

  # GET /short_visits
  # GET /short_visits.json
  def index
    @short_visits = @current_user.short_visits.all
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_short_visit
      @short_visit = @current_user.short_visits.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def short_visit_params
      params.require(:short_visit).permit(:short_url_id, :visitor_ip, :visitor_city, :visitor_state, :visitor_country, :visitor_country_iso)
    end

    def restrict_access
      authenticate_or_request_with_http_token do |token, options|
        ApiKey.exists?(access_token: token)
      end
    end

    def format_json?
      request.format.json?
    end

end


#curl -H "Authorization: Token 8a40509b67103b51d88ad9fdb0a1466b" http://localhost:4000/api/v1/short_visits.json