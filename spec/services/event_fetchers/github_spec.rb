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

  context "caching" do
    let(:now) { Time.current }
    let(:github_response) {  [{ "type" => "a" }, { "type" => "b" }, { "type" => "a" }] }
    let(:memory_store) { ActiveSupport::Cache.lookup_store(:memory_store) }
    let(:cache) { Rails.cache }

    before do
      allow(Rails).to receive(:cache).and_return(memory_store)
    end

    it "does not call Github client when called again within time limit" do
      allow(Clients::Github).to receive(:fetch_events).and_return(github_response)

      Timecop.freeze(now) do
        described_class.fetch(user: "uzer", repo_name: "ripo_naym", event_type: "a")
      end

      Timecop.freeze(now + EventFetchers::Github::EVENTS_TTL - 2.seconds) do
        described_class.fetch(user: "uzer", repo_name: "ripo_naym", event_type: "a")
      end

      expect(Clients::Github).to have_received(:fetch_events).once
    end

    it "calls Github client again when called after time limit is reached" do
      allow(Clients::Github).to receive(:fetch_events).and_return(github_response)

      Timecop.freeze(now) do
        described_class.fetch(user: "uzer", repo_name: "ripo_naym", event_type: "a")
      end

      Timecop.freeze(now + EventFetchers::Github::EVENTS_TTL + 1.second) do
        described_class.fetch(user: "uzer", repo_name: "ripo_naym", event_type: "a")
      end

      expect(Clients::Github).to have_received(:fetch_events).twice
    end

    it "calls Github client when parameters change" do
      allow(Clients::Github).to receive(:fetch_events).and_return(github_response)

      Timecop.freeze(now) do
        described_class.fetch(user: "uzer", repo_name: "ripo_naym", event_type: "a")
      end

      Timecop.freeze(now + EventFetchers::Github::EVENTS_TTL - 2.seconds) do
        described_class.fetch(user: "uzer", repo_name: "ripo_naym", event_type: nil)
      end

      expect(Clients::Github).to have_received(:fetch_events).twice
    end
  end
end
