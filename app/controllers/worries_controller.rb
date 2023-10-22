# \\wsl.localhost\Ubuntu\home\aivets\projects\worryaway\app\controllers\worries_controller.rb

class WorriesController < ApplicationController
  def new
    @worry = Worry.new
  end

  def create
    @worry = Worry.new(worry_params)

    if @worry.save
      redirect_to user_path(current_user), notice: 'お悩みが投稿されました。'
    else
      render :new
    end
  end

  private

  def worry_params
    params.require(:worry).permit(:image, :text).merge(user_id: current_user.id)
  end
end