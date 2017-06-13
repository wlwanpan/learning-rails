
# Can we rename Subbers to Servers that is what your app is tracking.
# If you were to stick with Subber I would prefer long form Subscribers over Subbers
class SubbersController < ApplicationController

  skip_before_action :verify_authenticity_token
  # GET request /subber # user should be pluralized /subbers
  def index
    @subber = Subber.all
    respond_to do |format|
      # Use a rabl view for all your actions. I created the basic folder structure to get you started but you need to add rabl gem and look at docs.
      format.json { render json: @subber.to_json(include: :statistics) }
    end
  end

  # POST request /subber/:id
  # POST requests will not have an id.  POST /subber
  def create
    # You can remove the subber exists check here. IF the subber name must be uniqe it is the models job to do the validation

    @subber = Subber.new(subber_params)
    if @subber.save
      #In a post action you should respond with the new records data. So the reponse will be the same as if you did a GET subber/:id
      # render :show
      puts "subber successfully saved"
    else
      # If the model is not saved correctly you should return an 422 error so the client can alert the user
      puts "subber not saved"
    end


  end
  # PUT/PATCH request /subber/:id
  def update
    @subber = Subber.find(params[:id])
    @subber.assign_attributes subber_params
    if @subber.save
      # Same comment for the post request. You should respond with the show template and alert the user when the update fails
      puts "suber was successfully updated"
      # render :show
    else
      puts "subber was not updated"
    end
  end

  def destroy
    @subber = Subber.find(params[:id])
    @subber.delete
    # respond with status 200
  end
  # GET request /subber/:id
  private

  # For ruby when it is private we don't indent
  #
  def subber_params
    params.require(:subber).permit(:key, :server_name, :server_location, :server_alias, :created_at, :statistics)
  end
end
