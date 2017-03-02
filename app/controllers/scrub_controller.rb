class ScrubController < ApplicationController

  def create
    # @image_scrubbing = ScrubValidator.new(scrub_params)
    params_validity = ScrubValidator.validate(params["img"])
    if params_validity == true
      ScrubValidator.send_to_queue
      render json: {response: "Image added to queue"}
    else
      render json: {
        response: "There was an error", 
        error: params_validity}
    end
    return
  end

end
