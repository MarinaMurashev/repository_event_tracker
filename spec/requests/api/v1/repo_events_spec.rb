require "rails_helper"

describe Api::V1::RepoEventsController, "GET#index" do
  before do
    allow(Clients::Github).to receive(:fetch_events).and_return({})
  end

  it "returns list of events as json" do
    get api_v1_repo_events_path

    expect(response.status).to eq 200
  end
end
