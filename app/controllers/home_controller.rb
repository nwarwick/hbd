class HomeController < ApplicationController
  
  def index
    authorize if params[:code]
  end

  private def authorize
    code = params[:code]
    Slack::Web::Api::Endpoints::OauthV2.oauth_v2_access(code)
  end
end
