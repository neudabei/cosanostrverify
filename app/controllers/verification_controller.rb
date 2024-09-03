class VerificationController < ApplicationController

  def serve_json
    render :file => 'public/nostr.json', 
      :content_type => 'application/json',
      :layout => false
  end
end
