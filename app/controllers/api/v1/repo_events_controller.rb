class Api::V1::RepoEventsController < ApplicationController
  def index
    user = params[:user]
    repo_name = params[:repo_name]

    if user && repo_name
      @events = EventFetchers::Github.fetch(user: user, repo_name: repo_name)
    else
      render json: { error: "required params: user, repo_name" }, status: :bad_request
    end
  end
end
