
class SubbersController < ApplicationController

  skip_before_action :verify_authenticity_token
  # GET request /subber
  def index
    @subber = Subber.all
    respond_to do |format|
      format.json { render json: @subber.to_json(include: :statistics) }
    end
  end

end
