require 'rails_helper'

describe Category do
  describe "validations" do
    it {is_expected.to validate_presence_of(:title)}
  end

  describe "relationships" do
    it {is_expected.to have_many(:jobs)}
  end
end
