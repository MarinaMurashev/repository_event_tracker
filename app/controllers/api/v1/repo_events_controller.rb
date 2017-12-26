class Api::V1::RepoEventsController < ApplicationController
  def index
    user = params[:user]
    repo_name = params[:repo_name]

    @events = Clients::Github.fetch_events(user: user, repo_name: repo_name)
  end
end
