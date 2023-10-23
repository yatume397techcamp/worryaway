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


  def update
    @worry = Worry.find(params[:id])
    if @worry.update(worry_params)
      redirect_to user_path(current_user), notice: 'お悩みが更新されました。'
    else
      render :edit
    end
  end

  def edit
    @worry = Worry.find(params[:id])
  end

  def edit_selected
    @selected_worries = Worry.find(params[:selected_worries])
    # 1つの悩みのみを編集するためのコード
    if @selected_worries.length == 1
      redirect_to edit_worry_path(@selected_worries.first)
    else
      # ここにエラーメッセージやアラートを表示するロジックを追加できます
      redirect_to user_path(current_user), alert: '1つの悩みのみを選択してください。'
    end
  end

  def destroy
    @worry = Worry.find(params[:id])
    @worry.destroy
    redirect_to user_path(current_user), notice: 'お悩みが削除されました。'
  end

  def destroy_selected
    Worry.where(id: params[:selected_worries]).destroy_all
    redirect_to user_path(current_user), notice: '選択されたお悩みが削除されました。'
  end

  private

  def worry_params
    params.require(:worry).permit(:image, :text).merge(user_id: current_user.id)
  end
end