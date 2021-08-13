# RSpec Railsの一般的な設定を読み込む
require 'rails_helper'

# 設定ファイルとヘルパーを読み込む
Dir[File.join(__dir__, 'system/support/**/*.rb')].each {|file| require file }
