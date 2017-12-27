require "rails_helper"

describe EventTypes::GithubPolicy, ".valid?" do
  it "is true when type matches the list" do
    valid_type = EventTypes::GithubPolicy::TYPES.first

    result = described_class.valid?(valid_type)

    expect(result).to eq true
  end

  it "is false when type does not match the list" do
    invalid_type = "invalid"

    result = described_class.valid?(invalid_type)

    expect(result).to eq false
  end
end
