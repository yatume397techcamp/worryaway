# \\wsl.localhost\Ubuntu\home\aivets\projects\worryaway\app\controllers\home_controller.rb


include HomeHelper
require 'httparty'

class HomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to user_path(current_user)
    end



    ambient_channel_id = '70794' # あなたのAmbientのチャンネルIDを入力
    ambient_read_key = '787a5a98866ad165' # あなたのAmbientのリードキーを入力
    response = HTTParty.get("https://ambidata.io/api/v2/channels/#{ambient_channel_id}/data?readKey=#{ambient_read_key}&n=1")

    if response.code == 200
      @data = response.parsed_response[0]
    else
      @data = 'データの取得に失敗しました'
    end

    @temperature_class = temperature_class(@data["d1"].to_f) if @data.is_a?(Hash)
  end
end
