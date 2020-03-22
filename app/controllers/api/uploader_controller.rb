class Api::UploaderController < ApiController
    def upload
        @upload = Upload.new(image: params[:image])
        # @image.save
        render json: {
            image: @upload.image
        }, status: :created
    end
end