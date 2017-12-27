module EventFetchers
  class Github
    EVENTS_TTL = 60.seconds

    def self.fetch(user:, repo_name:, event_type: nil)
      new(user: user, repo_name: repo_name, event_type: event_type).fetch
    end

    def initialize(user:, repo_name:, event_type: nil)
      @user = user
      @repo_name = repo_name
      @event_type = event_type
    end

    def fetch
      Rails.cache.fetch(cache_key, expires_in: EVENTS_TTL) do
        event_type.blank? ? event_results : filtered_event_results_by_event_type
      end
    end

    private

    def event_results
      @event_results ||= Clients::Github.fetch_events(user: user, repo_name: repo_name)
    end

    def filtered_event_results_by_event_type
      event_results.select { |event| event["type"] == event_type }
    end

    def cache_key
      [user, repo_name, event_type].join("/")
    end

    attr_reader :user, :repo_name, :event_type
  end
end
