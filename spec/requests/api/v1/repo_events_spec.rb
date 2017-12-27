require "rails_helper"

describe Api::V1::RepoEventsController, "GET#index" do
  let(:user) { "uzer" }
  let(:repo_name) { "ripo_naym" }
  let(:valid_params) { { user: user, repo_name: repo_name, event_type: nil } }

  it "responds with status of 200 and calls github client with params when all is well" do
    allow(EventFetchers::Github).to receive(:fetch)

    get api_v1_repo_events_path, params: valid_params

    expect(response.status).to eq 200
    expect(EventFetchers::Github).
      to have_received(:fetch).with(user: user, repo_name: repo_name, event_type: nil)
  end

  context "params validation" do
    it "returns bad_request when user not provided" do
      allow(EventFetchers::Github).to receive(:fetch)

      get api_v1_repo_events_path, params: valid_params.reject{ |k,v| k == :user }

      expect(response.status).to eq 400
      expect(EventFetchers::Github).to_not have_received(:fetch)
    end

    it "returns bad_request when repo_name not provided" do
      allow(EventFetchers::Github).to receive(:fetch)

      get api_v1_repo_events_path, params: valid_params.reject{ |k,v| k == :repo_name }

      expect(response.status).to eq 400
      expect(EventFetchers::Github).to_not have_received(:fetch)
    end

    it "returns bad_request when user and repo_name not provided" do
      allow(EventFetchers::Github).to receive(:fetch)

      get api_v1_repo_events_path, params: valid_params.reject{ |k,v| [:repo_name, :user].include? k }

      expect(response.status).to eq 400
      expect(EventFetchers::Github).to_not have_received(:fetch)
    end

    it "returns bad_request when invalid event_type is provided" do
      invalid_type = "invalid"
      allow(EventTypes::GithubPolicy).to receive(:valid?).with(invalid_type).and_return(false)
      allow(EventFetchers::Github).to receive(:fetch)

      get api_v1_repo_events_path, params: valid_params.merge(event_type: invalid_type)

      expect(response.status).to eq 400
      expect(EventFetchers::Github).to_not have_received(:fetch)
    end
  end
end
