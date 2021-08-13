module BetterRailsSystemTests
  # スクショやその他の生成物の保存場所に`Capybara.save_path`を指定する
  # （Railsのスクショのパスは設定不可能）
  # https://github.com/rails/rails/blob/49baf092439fc74fc3377b12e3334c3dd9d0752f/actionpack/lib/action_dispatch/system_testing/test_helpers/screenshot_helper.rb#L79
  def absolute_image_path
    Rails.root.join("#{Capybara.save_path}/screenshots/#{image_name}.png")
  end

  # 失敗したときのスクショをマルチセッションのセットアップと互換にする
  # 上で導入したCapybara.last_used_sessionはここで使う
  def take_screenshot
    return super unless Capybara.last_used_session

    Capybara.using_session(Capybara.last_used_session) { super }
  end
end

RSpec.configure do |config|
  config.include BetterRailsSystemTests, type: :system

  # メイラー内のURLに正しいサーバーホストが含まれるようにする
  # メールに含まれるリンクのテストで必要（capybara-emaiなど）
  config.around(:each, type: :system) do |ex|
    was_host = Rails.application.default_url_options[:host]
    Rails.application.default_url_options[:host] = Capybara.server_host
    ex.run
    Rails.application.default_url_options[:host] = was_host
  end

  # このフックが他のものより先に実行されるようにする
  config.prepend_before(:each, type: :system) do
    # 常にJSドライバを使うようにする
    driven_by Capybara.javascript_driver
  end
end
