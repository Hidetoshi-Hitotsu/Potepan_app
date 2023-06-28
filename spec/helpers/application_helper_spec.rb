require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "#page_title" do
    context "引数がnilである" do
      it "BIGBAG Storeが表示される" do
        expect(page_title('')).to eq('BIGBAG Store')
      end
    end

    context "引数がnilでない" do
      it "pagetitleとBIGBAG Storeが表示される" do
        expect(page_title('PageTitle')).to eq('PageTitle - BIGBAG Store')
      end
    end
  end
end
