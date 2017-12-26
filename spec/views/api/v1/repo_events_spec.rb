require "rails_helper"

describe "api/v1/repo_events/index" do
  let(:event) do
    {
      "id" => 7031164171,
      "type" => "IssuesEvent",
      "actor" =>{
        "id" => 6064830,
        "login" => "Strangehill",
        "display_login" => "Strangehill",
        "gravatar_id" => "abc",
        "url" => "g.com/users/Strangehill",
        "avatar_url" => "avatars.com/u/6064830"
      },
      "created_at" => "2017-12-26T15:33:32Z",
    }
  end

  it "includes id's" do
    assign(:events, [event.merge("id" => 123), event.merge("id" => 456), event.merge("id" => 7)])
    render

    expect(rendered_response.size).to eq 3
    expect(rendered_response.map{ |e| e["id"] }).to eq([123, 456, 7])
  end

  it "includes types" do
    assign(:events, [event.merge("type" => "AnEvent"), event.merge("type" => "RandomEvent")])
    render

    expect(rendered_response.size).to eq 2
    expect(rendered_response.map{ |e| e["type"] }).to eq(["AnEvent", "RandomEvent"])
  end

  it "includes actors and their fields" do
    assign(
      :events,
      [
        event,
        event.merge(
          "actor" => {
            "id" => 57,
            "login" => "mylogin",
            "display_login" => "howdy",
            "gravatar_id" => "def",
            "url" => "abc.com",
            "avatar_url" => "avatars.com",
          }
        ),
      ]
    )
    render

    expect(rendered_response.size).to eq 2
    expect(rendered_response.map{ |e| e["actor"]["id"] }).to eq([6064830, 57])
    expect(rendered_response.map{ |e| e["actor"]["login"] }).to eq(["Strangehill", "mylogin"])
    expect(rendered_response.map{ |e| e["actor"]["display_login"] }).to eq(["Strangehill", "howdy"])
    expect(rendered_response.map{ |e| e["actor"]["gravatar_id"] }).to eq(["abc", "def"])
    expect(rendered_response.map{ |e| e["actor"]["url"] }).to eq(["g.com/users/Strangehill", "abc.com"])
    expect(rendered_response.map{ |e| e["actor"]["avatar_url"] }).to eq(["avatars.com/u/6064830", "avatars.com"])
  end

  it "includes created_at timestamps" do
    assign(:events, [event.merge("created_at" => "2017-12-27T15:33:32Z"), event.merge("created_at" => "2017-11-26T15:33:32Z")])
    render

    expect(rendered_response.size).to eq 2
    expect(rendered_response.map{ |e| e["created_at"] }).to eq(["2017-12-27T15:33:32Z", "2017-11-26T15:33:32Z"])
  end

  def rendered_response
    JSON.parse(rendered)
  end
end
