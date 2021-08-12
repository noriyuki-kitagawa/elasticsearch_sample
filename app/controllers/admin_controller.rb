class AdminController < ApplicationController
  def index
  end

  def show
    render(json: 'test')
  end
end
