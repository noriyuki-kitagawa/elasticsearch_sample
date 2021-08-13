# 特にSeleniumを使う場合、開発者はこのmax wait timeを増やす傾向がよく見られる
# Cupriteの場合そうした設定は不要
# ここではCapybaraのデフォルト値を明示的に指定している
Capybara.default_max_wait_time = 2

# `has_text?`や同種のマッチャーでホワイトスペースを正規化する
# （つまり改行や末尾スペースなどは無視される）
# こうすることで、UIにささいな変更が入っても影響されにくくなる
Capybara.default_normalize_ws = true

# システムテストで生成されるファイル（スクショやダウンロードファイルなど）の置き場所
# このパスを外部から設定可能にしておくとCIなどで便利かもしれない
Capybara.save_path = ENV.fetch('CAPYBARA_ARTIFACTS', './tmp/capybara')

# Capybara.using_sessionを使うと、別のブラウザセッションを制御できるようになります。
# それによって、1つのテストシナリオで複数の独立セッションを制御できます。これはリアルタイム機能のテストで特に有用です
Capybara.singleton_class.prepend(
  Module.new do
    attr_accessor :last_used_session

    def using_session(name, &block)
      self.last_used_session = name
      super
    ensure
      self.last_used_session = nil
    end
  end
)
