# frozen_string_literal: true

module Api
  module V1
    class UsersController < ActionController::API
      before_action :set_user, only: %i[show update destroy]

      def index
        users = User.all
        render json: users,
               include: %w[team],
               meta: { total_count: users.total_count }
      end

      def search
        render json: User.active.search(filtering_params)
      end

      def show
        render json: @user
      end

      def sync_users
        SlackClient.new.sync_users
      end

      def create
        user = User.new(user_params)
        if user.save
          render json: user, status: :created
        else
          render json: user.errors, status: :unprocessable_entity
        end
      end

      def update
        if @user.update(user_params)
          render json: @user, status: :ok
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @user.destroy
      end

      def delete_multiple
        User.where(id: params[:user_ids]).destroy_all
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(
          :name,
          :description,
          :is_active,
          :team_id,
          :last_message,
          :role,
          :uid
        )
      end

      def filtering_params
        params.permit(:by_name, :active_status, :by_role)
      end
    end
  end
end
