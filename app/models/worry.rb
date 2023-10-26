# \\wsl.localhost\Ubuntu\home\aivets\projects\worryaway\app\models\worry.rb

class Worry < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  
  def transparency_level
    days_passed = (Time.now - updated_at).to_i / 1.day
    [1 - 0.1 * days_passed, 0.1].max
  end

  validate :must_have_image_or_text

  private

  def must_have_image_or_text
    if !image.attached? && text.blank?
      errors.add(:base, "画像またはテキストのどちらかを入力してください。")
    end
  end
  
end
