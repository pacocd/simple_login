class Api::V1::UsersController < ApplicationController
    def index
        @users = User.all

        render json: @users, status: :ok
    end

    def create
        @user = User.new(create_user_params)
        if @user.save
            render json: @user, status: :ok
        else
            render json: { errors: @user.errors }, status: :conflict
        end
    end

    def destroy
        @user = User.find(delete_user_params[:id])

        if @user.destroy
            render json: { message: "Borrado con éxito" }, status: :accepted
        else
            render json: { message: "Algo salió mal" }, status: :not_found
        end
    end

    def login
        @user = User.find_by(username: login_parameters[:username])

        if @user.present? && @user.password == params[:password]
            render json: @user, status: :ok
        else
            render json: { message: "Usuario o contraseña no válidos" }, status: :not_found
        end
    end

    private

    def create_user_params
        params.permit(:username, :name, :password)
    end

    def delete_user_params
        params.permit(:id)
    end

    def login_parameters
        params.permit(:username, :password)
    end
end
