module MokusHelper
  def options_for_mjn
      Constants.options_for_mjn
  end

  def format_moku_time
    hours = moku_time / (60 * 60)
    minutes = moku_time / 60.floor
    seconds = moku_time
    return "#{hours}時間　#{minutes}分 #{seconds}秒"
  end
end
