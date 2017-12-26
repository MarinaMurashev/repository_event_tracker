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

  it "defaults page parameter to 1 when it is not provided" do
    stub_request(:get, request_url).
      with(query: { page: 1 }).
      to_return(status: 200, body: response_body.to_json)

    result = described_class.fetch_events(user: user, repo_name: repo_name)

    expect(result).to eq(response_body)
  end

  it "passes provided page parameter as part of the request" do
    stub_request(:get, request_url).
      with(query: { page: 2 }).
      to_return(status: 200, body: response_body.to_json)

    result = described_class.fetch_events(user: user, repo_name: repo_name, page: 2)

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
end
