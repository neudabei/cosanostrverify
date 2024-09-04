class VerificationController < ApplicationController

  def serve_json
    render :json => JsonCreatorService.new.content
  end
end
