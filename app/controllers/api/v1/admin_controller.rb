module Api
  module V1
    class AdminController < ApplicationController
      def index
        render(json: User.all.map(&:name))
      end
    end
  end
end
