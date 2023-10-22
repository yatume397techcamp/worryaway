# \\wsl.localhost\Ubuntu\home\aivets\projects\worryaway\app\models\worry.rb

class Worry < ApplicationRecord
  belongs_to :user
  has_one_attached :image
end
