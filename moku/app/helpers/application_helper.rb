module ApplicationHelper

  # constants.rbで定義
  def options_for_public
      Constants.options_for_public
  end

  # viewで公開設定の内容をconstants.rbで決めた定数に基づき表示するためのメソッド
  def public_to_s(value)
    if value == Constants::PUBLIC
      Constants::PUBLIC_VALUE
    else
        Constants::PRIVATE_VALUE
    end
  end

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
