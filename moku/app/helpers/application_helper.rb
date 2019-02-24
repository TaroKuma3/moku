module ApplicationHelper

  def greeting
    now = Time.current.hour
    eary_morning = (4..6).include?(now)
    morning = (7..10).include?(now)
    lunchtime = (11..14).include?(now)
    snacktime = (15..16).include?(now)
    evening = (17..18).include?(now)
    night = (19..24).include?(now)

    if eary_morning
        "早起きですね"
    elsif morning
        "おはようございます"
    elsif lunchtime
        "こんにちは"
    elsif snacktime
        "今日のおやつはなんですか"
    elsif evening
        "そろそろ今日もおしまいですね"
    elsif night
        "こんばんわ"
    else
        "遅くまでお疲れ様です"
    end
  end

end
