require "rails_helper"

describe EventFetchers::Github, ".fetch" do
  it "call github client with the passed in arguments and returns the results" do
    github_response = [{ "a" => "b" }, { "c" => "d" }]
    allow(Clients::Github).to receive(:fetch_events).and_return(github_response)

    result = described_class.fetch(user: "uzer", repo_name: "ripo_naym")

    expect(result).to eq github_response
  end
end
