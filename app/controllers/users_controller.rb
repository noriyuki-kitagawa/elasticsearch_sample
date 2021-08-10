class UsersController < ApplicationController
  def index
    @query = params[:query]
    @users = if @query.present?
      User.search(@query).records
    else
      User.__elasticsearch__.all
    end
  end
end
