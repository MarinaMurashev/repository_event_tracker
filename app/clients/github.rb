module Clients
  class Github
    class ResponseError < StandardError; end

    API_URL = "https://api.github.com".freeze
    EVENTS_ENDPOINT = "/repos/%{user}/%{repo_name}/events".freeze
    LINK_TYPES = [
      NEXT = "next".freeze,
      LAST = "last".freeze,
    ].freeze

    def self.fetch_events(user:, repo_name:)
      new(user: user, repo_name: repo_name).fetch_events
    end

    def initialize(user:, repo_name:)
      @user = user
      @repo_name = repo_name
      @events = []
    end

    def fetch_events
      handle_response(initial_response)

      return @events if second_page_link.blank?

      fetch_events_from_subsequent_pages

      @events
    end

    private

    def fetch_events_from_subsequent_pages
      next_page_link = second_page_link
      (2..last_page).each do |page|
        link = page == last_page ? last_page_link : next_page_link
        next_response = connection.get(link)

        handle_response(next_response)

        next_page_link = page_link_for(response: next_response, type: NEXT)
      end
    end

    def handle_response(response)
      response_body = JSON.parse(response.body)

      if response.status == 200
        @events += response_body
      else
        raise ResponseError, response_body["message"]
      end
    end

    def connection
      @connection ||= Faraday.new(url: API_URL)
    end

    def next_page_link(response)
      link_header = link_header_for(response)

      return if link_header.blank?

      page_link_for(response: response, type: NEXT)
    end

    def page_link_for(response:, type:)
      link_header = link_header_for(response)

      return if link_header.blank?

      page_info = link_header.split(",").detect{ |link| link.include?("rel=\"#{type}\"") }

      return if page_info.blank?

      page_info.split(";").first.gsub("<","").gsub(">","").squish
    end

    def initial_endpoint
      EVENTS_ENDPOINT % { user: user, repo_name: repo_name }
    end

    def initial_response
      @initial_response ||= connection.get(initial_endpoint)
    end

    def last_page_link
      @last_page_link ||= page_link_for(response: initial_response, type: LAST)
    end

    def last_page
      @last_page ||= begin
        last_page_uri = URI(last_page_link)
        last_page_uri_params = URI::decode_www_form(last_page_uri.query).to_h
        last_page_uri_params["page"].to_i
      end
    end

    def second_page_link
      @second_page_link ||= page_link_for(response: initial_response, type: NEXT)
    end

    def link_header_for(response)
      response.headers["link"]
    end

    attr_reader :user, :repo_name
  end
end
