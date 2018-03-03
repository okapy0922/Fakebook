class UsersController < ApplicationController
  def index
    @users = User.all
    @users_without_me = User.where.not(id: current_user.id)
  end
end
