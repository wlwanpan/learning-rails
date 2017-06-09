
class SubbersController < ApplicationController

  skip_before_action :verify_authenticity_token
  # GET request /subber
  def index
    @subber = Subber.all
    respond_to do |format|
      format.json { render json: @subber.to_json(include: :stats) }
    end
  end
  # POST request /subber/:id
  def create
    unless Subber.exists?(server_name: params[:server_name])
      @subber = Subber.new(subber_params)
      if @subber.save
        puts "subber successfully saved"
      else
        puts "subber not saved"
      end
    end

  end
  # PUT/PATCH request /subber/:id
  def update
    @subber = Subber.find(params[:id])
    @subber.assign_attributes subber_params
    if @subber.save
      puts "suber was successfully updated"
    else
      puts "subber was not updated"
    end
  end

  def destroy
    @subber = Subber.find(params[:id])
    @subber.delete
  end
  # GET request /subber/:id
  private
    def subber_params
      params.require(:subber).permit(:key, :server_name, :server_location, :server_alias, :created_at, :stats)
    end
end
