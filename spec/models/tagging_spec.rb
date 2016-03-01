require 'rails_helper'

RSpec.describe Tagging, type: :model do
  describe "db structure" do
    it { is_expected.to have_db_column(:template_id).of_type(:integer) }
    it { is_expected.to have_db_column(:tag_id     ).of_type(:integer) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:template_id) }
    it { is_expected.to validate_presence_of(:tag_id) }
  end

  describe "associations" do
    it { is_expected.to belong_to(:template) }
    it { is_expected.to belong_to(:tag) }
  end
end
