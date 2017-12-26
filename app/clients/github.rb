module Clients
  class Github
    class ResponseError < StandardError; end

    API_URL = "https://api.github.com".freeze
    EVENTS_ENDPOINT = "/repos/%{user}/%{repo_name}/events".freeze

    def self.fetch_events(user:, repo_name:, page: 1)
      conn = Faraday.new(url: API_URL)
      endpoint = EVENTS_ENDPOINT % { user: user, repo_name: repo_name }
      response = conn.get(endpoint, page: page)
      response_body = JSON.parse(response.body)

      return response_body if response.status == 200

      raise ResponseError, response_body["message"]
    end
  end
end
