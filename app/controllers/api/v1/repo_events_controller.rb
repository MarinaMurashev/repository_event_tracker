class Api::V1::RepoEventsController < ApplicationController
  def index
    user = "shopify" #placeholder
    repo_name = "liquid" #placeholder
    @events = Clients::Github.fetch_events(user: user, repo_name: repo_name)
  end
end
