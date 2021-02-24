class WelcomeController < ApplicationController

    def index
        @text = "Hello world!"
        render json: @text
    end

end
