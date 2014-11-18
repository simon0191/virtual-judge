class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  # GET /users
  # GET /users.json
  def index
    @users = User.order points: :desc
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

end