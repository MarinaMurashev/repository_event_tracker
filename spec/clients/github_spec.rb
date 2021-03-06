require "rails_helper"

describe Clients::Github, ".fetch_events" do
  let(:user) { "shopify" }
  let(:repo_name) { "liquid" }
  let(:response_body) { [{"a" => "b"}] }
  let(:request_url) { "https://api.github.com/repos/#{user}/#{repo_name}/events" }

  it "calls github url with provided user and repo name and responds with json-parsed body" do
    stub_request(:get, request_url).
      with(query: hash_including({})).
      to_return(status: 200, body: response_body.to_json)

    result = described_class.fetch_events(user: user, repo_name: repo_name)

    expect(result).to eq(response_body)
  end

  it "raises an error when request is not successful" do
    error_response_body = { "message" => "not found" }
    stub_request(:get, request_url).
      with(query: hash_including({})).
      to_return(status: 404, body: error_response_body.to_json)

    expect {
      described_class.fetch_events(user: user, repo_name: repo_name)
    }.to raise_error(Clients::Github::ResponseError, "not found")
  end

  context "multi-page response" do
    let(:base_link) { "https://api.github.com/repositories/15435/events" }

    it "makes subsequent requests to fetch all results if link headers provided" do
      first_link = "#{base_link}?page=2"
      next_link = "#{base_link}?page=2"
      last_link = "#{base_link}?page=3"
      initial_link_header = "<#{next_link}>; rel=\"next\", <#{last_link}>; rel=\"last\""
      intermediate_link_header = "<#{next_link}>; rel=\"next\", <#{last_link}>; rel=\"last\", <#{first_link}>; rel=\"prev\", <#{first_link}>; rel=\"first\""
      last_link_header = "<#{first_link}>; rel=\"first\", <#{next_link}>; rel=\"prev\""
      stub_request(:get, request_url).
        to_return(status: 200, body: [{"a" => "b"}].to_json, headers: { "Link" => initial_link_header })
      stub_request(:get, next_link).
        to_return(status: 200, body: [{"b" => "c"}].to_json, headers: { "Link" => intermediate_link_header })
      stub_request(:get, last_link).
        to_return(status: 200, body: [{"c" => "d"}].to_json, headers: { "Link" => last_link_header })

      result = described_class.fetch_events(user: user, repo_name: repo_name)

      expect(result).to eq([{ "a" => "b" }, { "b" => "c" }, { "c" => "d" }])
    end
  end
end
