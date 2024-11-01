class VerificationController < ApplicationController
  before_action :set_cors_header

  def serve_json
    render :json => JsonCreatorService.new.content(name: params[:name])
  end

  private

  def set_cors_header
    headers['Access-Control-Allow-Origin'] = '*'
  end
end
