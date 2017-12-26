require "rails_helper"

describe Api::V1::RepoEventsController, "GET#index" do
  it "responds with status of 200 when all is well" do
    allow(Clients::Github).to receive(:fetch_events).and_return({})

    get api_v1_repo_events_path

    expect(response.status).to eq 200
  end

  it "calls the Github client with parameters" do
    allow(Clients::Github).to receive(:fetch_events)

    get api_v1_repo_events_path, params: { user: "uzer", repo_name: "ripo_naym" }

    expect(Clients::Github).to have_received(:fetch_events).with(user: "uzer", repo_name: "ripo_naym")
  end
end
