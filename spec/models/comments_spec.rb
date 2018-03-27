require 'rails_helper'

describe Comment do
  describe "validations" do
    it {is_expected.to validate_presence_of(:content)}
  end

  describe "relationships" do
    it {is_expected.to belong_to(:job)}
  end
end
