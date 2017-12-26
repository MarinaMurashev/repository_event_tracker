class Api::V1::RepoEventsController < ApplicationController
  def index
    # placeholder for call to https://api.github.com/repos/shopify/liquid/events
    @events = [
      {
        id: 7031164171,
        type: "IssuesEvent",
        actor: {
          id: 6064830,
          login: "Strangehill",
          display_login: "Strangehill",
          gravatar_id: "",
          url: "https://api.github.com/users/Strangehill",
          avatar_url: "https://avatars.githubusercontent.com/u/6064830?"
        },
        created_at: "2017-12-26T15:33:32Z",
      }
    ]
  end
end
