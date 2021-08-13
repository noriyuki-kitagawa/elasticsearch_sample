RSpec.configure do |config|
  # システムspecを除外する場合はアセットプリコンパイルをスキップする
  # （以下のコマンドでシステムテスト以外を実行する場合など）
  #
  #    rspec --tag ~type:system
  #
  # なお、ここではアセットプリコンパイルは不要
  next if config.filter.opposite.rules[:type] == 'system' || config.exclude_pattern.match?(%r{spec/system})

  config.before(:suite) do
    # テストでwebpack-dev-serverも使う
    # フロントエンドのコード修正をシステムテストで確認したい場合に便利
    if Webpacker.dev_server.running?
      $stdout.puts "\n⚙️  Webpack dev server is running! Skip assets compilation.\n"
      next
    else
      $stdout.puts "\n🐢  Precompiling assets.\n"

      # webpacker:compile Rakeタスクを実行する
      # ...
    end
  end
end
