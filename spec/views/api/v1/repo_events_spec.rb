require "rails_helper"

describe "api/v1/repo_events/index" do
  it "displays event id's" do
    assign(:events, [{ id: 123 }, { id: 456 }])
    render

    rendered_response = JSON.parse(rendered)
    expect(rendered_response.size).to eq 2
    expect(rendered_response.map{ |event| event["id"] }).to eq([123, 456])
  end
end
