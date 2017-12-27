require "rails_helper"

describe EventFetchers::Github, ".fetch" do
  it "call github client with the passed in arguments and returns the results" do
    github_response = [{ "a" => "b" }, { "c" => "d" }]
    allow(Clients::Github).to receive(:fetch_events).and_return(github_response)

    result = described_class.fetch(user: "uzer", repo_name: "ripo_naym")

    expect(result).to eq github_response
  end

  it "filters results by event type" do
    github_response = [{ "type" => "a" }, { "type" => "b" }, { "type" => "a" }]
    allow(Clients::Github).to receive(:fetch_events).and_return(github_response)

    result = described_class.fetch(user: "uzer", repo_name: "ripo_naym", event_type: "a")

    expect(result.size).to eq 2
    expect(result.map { |e| e["type"] }.uniq).to eq(["a"])
  end
end
