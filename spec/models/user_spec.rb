require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    validate_presence_of :name
  end
end
    