# \\wsl.localhost\Ubuntu\home\aivets\projects\worryaway\app\controllers\users_controller.rb

class UsersController < ApplicationController

  def show
    @worries = current_user.worries.where(page: "トップ")
  end

  def temp
    @worries = current_user.worries.where(page: "一時")
    render :show
  end

end
