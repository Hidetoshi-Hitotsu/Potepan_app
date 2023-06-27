require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "#page_title" do
    context "pagetitleがnilである" do
      it "BIGBAG Storeが表示される" do
        expect(pagetitle('')).to eq('BIGBAG Store')
      end
    end

    context "pagetitleがnilでない" do
      it "pagetitleとBIGBAG Storeが表示される" do
        expect(pagetitle('PageTitle')).to eq('PageTitle - BIGBAG Store')
      end
    end
  end
end
