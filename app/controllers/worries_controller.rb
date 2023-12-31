# \\wsl.localhost\Ubuntu\home\aivets\projects\worryaway\app\controllers\worries_controller.rb

class WorriesController < ApplicationController
  def new
    @worry = Worry.new
  end

  def create
    if params[:edit]
      edit_selected
      return  
    end
  
    @worry = Worry.new(worry_params)
    @worry.page = 'トップ'
    
    # 画像が添付されていないかつテキストが存在する場合、デフォルトの画像を添付
    if !@worry.image.attached? && @worry.text.present?
      @worry.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'no_image.png')), filename: 'no_image.png', content_type: 'image/png')
    end
    
    if @worry.save
      redirect_to user_path(current_user), notice: 'お悩みが投稿されました。'
    else
      # flash[:alert] = '・画像またはテキストのどちらかを入力してください。'
      render :new, status: :unprocessable_entity #お悩みデータの保存に失敗した場合
    end
  end

  def update
    @worry = Worry.find(params[:id])
    if @worry.update(worry_params)
      if params[:worry][:from_temp_page] == 'true'
        redirect_to temp_page_path, notice: 'お悩みが更新されました。'
      else
        redirect_to user_path(current_user), notice: 'お悩みが更新されました。'
      end
    else
      render :edit
    end
  end

  def edit
    @worry = Worry.find(params[:id])
    
    unless @worry.user == current_user
      redirect_to user_path(current_user), alert: '他のユーザーのお悩みを編集することはできません。'
      return
    end
  
    @from_temp_page = request.referer&.include?(temp_page_path)
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

  def move_to_temp
    if params[:commit] == 'データ削除'
      Worry.where(id: params[:selected_worries]).destroy_all
      redirect_to user_path(current_user), notice: '選択されたお悩みが削除されました。'
    elsif params[:edit]
      edit_selected
      return
    else
      @worries = Worry.where(id: params[:selected_worries])
      @worries.update_all(page: '一時')
      redirect_to user_path(current_user), notice: '選択されたお悩みが一時フォルダに移動されました。'
    end
  end

  def move_from_temp
    if params[:commit] == 'データ削除'
      Worry.where(id: params[:selected_worries]).destroy_all
      redirect_to temp_page_path, notice: '選択されたお悩みが削除されました。'
    elsif params[:edit]
      edit_selected
      return
    else
      @worries = Worry.where(id: params[:selected_worries])
      @worries.update_all(page: 'トップ')
      redirect_to temp_page_path, notice: '選択されたお悩みがメインページに移動されました。'
    end
  end
  
  def remove_image
    @worry = Worry.find(params[:id])
    @worry.image.purge  # 画像を削除
    redirect_to edit_worry_path(@worry), notice: '画像が削除されました。'
  end

  def move_to_main
    @worries = Worry.where(id: params[:selected_worries])
    @worries.update_all(page: 'トップ')
    redirect_to temp_page_path, notice: '選択されたお悩みがメインページに移動されました。'
  end

  private

  def worry_params
    params.require(:worry).permit(:image, :text).merge(user_id: current_user.id)
  end
end