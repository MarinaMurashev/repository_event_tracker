class HomeController < ApplicationController
  def index
    @default_user = "marinamurashev"
    @default_repo_name = "repository_event_tracker"
  end
end
