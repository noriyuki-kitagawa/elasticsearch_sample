module Users
  class GoodsController < ApplicationController
    def create
      slack
      line
    end

    private

      def slack
        notifier = Slack::Notifier.new(
          ENV['SLACK_WEBHOOK_URL'],
          channel: '#general'
        )
        notifier.ping 'superからいいねされました'
      end

      def line
        uri = URI.parse('https://notify-api.line.me/api/notify')
        request = Net::HTTP::Post.new(uri)
        request['Authorization'] = "Bearer #{ENV['LINE_TOKEN']}"
        request.set_form_data(message: 'superからいいねされました')
        Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |https|
          https.request(request)
        end
      end
  end
end
