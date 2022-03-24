class Api::V1::UsersController < ApplicationController
    def index
        @users = User.all

        render json: @users, status: 200
    end

    def create
        @user = User.new(user_params)
        if @user.save
            render json: @user, status: 200
        else
            render json: { errors: @user.errors }, status: 422
        end
    end

    private

    def user_params
        params.permit(:username, :name, :password)
    end
end
