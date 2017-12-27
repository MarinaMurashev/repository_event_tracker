module EventFetchers
  class Github
    def self.fetch(user:, repo_name:)
      new(user: user, repo_name: repo_name).fetch
    end

    def initialize(user:, repo_name:)
      @user = user
      @repo_name = repo_name
    end

    def fetch
      event_results
    end

    private

    def event_results
      @event_results ||= Clients::Github.fetch_events(user: user, repo_name: repo_name)
    end

    attr_reader :user, :repo_name
  end
end
