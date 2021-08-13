# 最初にCuprite〜Capybara統合を読み込む
require 'capybara/cuprite'

# 続いてドライバを登録し、後で使えるようにする
# ここでは#driven_byメソッドを利用する
Capybara.register_driver(:cuprite) do |app|
  Capybara::Cuprite::Driver.new(
    app,
    **{
      window_size: [1200, 800],
      # Docker化環境向けの追加設定については、本記事の対応するセクションを参照のこと
      browser_options: {},
      # Chrome起動時のwait timeを増やす（CIビルドを安定させるのに必要）
      process_timeout: 10,
      # デバッグ機能を有効にする
      inspector: true,
      # HEADLESS環境変数をfalsyな値に設定することで
      # Chromeを「ヘッドフルモード」で実行できるようにする
      headless: !ENV["HEADLESS"].in?(%w[n 0 no false]),
    },
  )
end

# Capybaraで:cupriteドライバをデフォルトで使うよう設定する
Capybara.default_driver = Capybara.javascript_driver = :cuprite
