class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.all
    @users_without_me = User.where.not(id: current_user.id)
  end
end
