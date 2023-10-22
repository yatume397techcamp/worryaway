# \\wsl.localhost\Ubuntu\home\aivets\projects\worryaway\app\controllers\users_controller.rb

class UsersController < ApplicationController
  def show
    @worries = current_user.worries
  end
end
