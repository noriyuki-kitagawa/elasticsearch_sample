module CupriteHelpers
  # 実行を停止する#pauseメソッドはテストのどこにでも置ける
  # ヘッドフルモードのテスト中にWebページの表示内容をチェックしたい場合に便利
  def pause
    page.driver.pause
  end

  # Chromeインスペクタを開いて実行を一時停止する#debugメソッドは
  # テストのどこにでも置ける
  def debug(*args)
    page.driver.debug(*args)
  end
end

RSpec.configure do |config|
  config.include CupriteHelpers, type: :system
end
