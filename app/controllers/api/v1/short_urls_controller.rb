class  Api::V1::ShortUrlsController < ApplicationController
  before_filter :restrict_access , :if => :format_json?

  before_action :set_short_url, only: [:show, :edit, :update, :destroy]

  layout 'application'


  def redirect_short
    record = @current_user.short_urls.find_by(shorty: params["token"])
    ActiveRecord::Base.transaction do
      org_url = record.orginal_url
      record.update_attribute('visit_count',((record.visit_count||0) + 1))
      record.create_vist_geo_details(request)
      redirect_to org_url
      end
    rescue
  end

  # GET /short_urls
  # GET /short_urls.json
  def index
    @short_urls = @current_user.short_urls.all
  end

  # GET /short_urls/new
  def new
    @short_url = @current_user.short_urls.new
    respond_to do |format|
      format.html {}
      format.json {render json: {status:true}}
    end
  end

  # POST /short_urls
  # POST /short_urls.json
  def create
    @short_url = @current_user.short_urls.new(short_url_params)
    @short_url.orginal_url = @short_url.smart_add_url_protocol
    @short_url.shorty=ShortUrl.generate_token
    @short_url.user_id=@current_user.id
    respond_to do |format|
      if @short_url.save
        format.html { redirect_to action: 'index', notice: 'Short url was successfully created.' }
        format.json { render json: {status: true }}
      else
        format.html { render action: 'new' }
        format.json { render json: {status:false,error:@short_url.errors} }
      end
    end
  end

  # DELETE /short_urls/1
  # DELETE /short_urls/1.json
  def destroy
    @short_url.destroy
    respond_to do |format|
      format.html { redirect_to action: 'index', notice: 'Short url was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_short_url
      @short_url = @current_user.short_urls.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def short_url_params
      params.require(:short_url).permit(:orginal_url)
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

#curl -H "Authorization: Token 8a40509b67103b51d88ad9fdb0a1466b" http://localhost:4000/api/v1/short_urls.json