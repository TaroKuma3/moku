class Constants

  PUBLIC =  true
  PRIVATE = false

  PUBLIC_VALUE = "公開"
  PRIVATE_VALUE = "非公開"


  def self.options_for_public
    [[PUBLIC_VALUE, PUBLIC], [PRIVATE_VALUE, PRIVATE]]
  end

  DEFAULT_MOKU_TYPE_NAME = "とりあえずMOKUる"
end