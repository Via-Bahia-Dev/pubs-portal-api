require 'rails_helper'

RSpec.describe Status, type: :model do

  describe "db structure" do
    it { is_expected.to have_db_column(:name).of_type(:text) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
  end
end
