require 'rails_helper'

RSpec.describe Status, type: :model do

  describe "db structure" do
    it { is_expected.to have_db_column(:name ).of_type(:string) }
    it { is_expected.to have_db_column(:color).of_type(:integer) }
    it { is_expected.to have_db_column(:order).of_type(:integer) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:color) }
    it { is_expected.to validate_presence_of(:order) }
  end
end
