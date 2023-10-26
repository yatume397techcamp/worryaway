# \\wsl.localhost\Ubuntu\home\aivets\projects\worryaway\app\helpers\home_helper.rb

module HomeHelper
  def temperature_class(temp)
    return 'cold' if temp < 24
    return 'warm' if temp.between?(24, 26)
    return 'hot' if temp > 26
  end
end