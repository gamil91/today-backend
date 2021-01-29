class UsersController < ApplicationController
    # skip_before_action :authorized, only: [:create, :login]


    def show 
        user = User.find(params[:id])
        render json: {user: UserSerializer.new(current_user)}
    end

    def create
        user = User.new(user_params)
        if user.save
            token = encode_token(user_id: user.id)
            render json: {user: UserSerializer.new(user), token: token}
        else
            render json: {error: user.errors.full_messages}
        end
    end

    def update
        user = User.find(params[:id])
        if user.update(user_params)
            render json: {user: UserSerializer.new(user)}
        else
            render json: {error: user.errors.full_messages}
        end
    end

    def login
        # byebug
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            token = encode_token(user_id: user.id)
            render json: {user: UserSerializer.new(user), token: token}
        else
            render json: {error: "Incorrect credentials, please try again."}
        end
    end

    def get_user
        render json: {user: UserSerializer.new(current_user)}
    end

    def destroy
        user = User.find(user_params[:id])
        user.destroy
        render json: user
    end


    private

    def user_params
        params.permit(:name, :email, :password, :id)
    end

end
